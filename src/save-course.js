const { DynamoDBClient } = require("@aws-sdk/client-dynamodb");
const { DynamoDBDocumentClient, PutCommand } = require("@aws-sdk/lib-dynamodb");

const client = new DynamoDBClient({ region: "eu-central-1" });
const ddbDocClient = DynamoDBDocumentClient.from(client);

exports.handler = async (event) => {
  try {
    // unpack body from text to object
    const requestBody = JSON.parse(event.body);
    
    const id = requestBody.title.replace(/\s+/g, '-').toLowerCase();
    const item = {
      id: id,
      title: requestBody.title,
      watchHref: `http://www.pluralsight.com/courses/${id}`,
      authorId: requestBody.authorId,
      length: requestBody.length,
      category: requestBody.category
    };

    const params = {
      TableName: "cloudtech-dev-courses",
      Item: item
    };

    await ddbDocClient.send(new PutCommand(params));
    return {
      statusCode: 200,
      headers: { "Access-Control-Allow-Origin": "*", "Content-Type": "application/json" },
      body: JSON.stringify(item)
    };
  } catch (err) {
    console.error(err);
    return {
      statusCode: 500,
      headers: { "Access-Control-Allow-Origin": "*", "Content-Type": "application/json" },
      body: JSON.stringify({ error: err.message })
    };
  }
};