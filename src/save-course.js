const { DynamoDBClient } = require("@aws-sdk/client-dynamodb");
const { DynamoDBDocumentClient, PutCommand } = require("@aws-sdk/lib-dynamodb");

const client = new DynamoDBClient({ region: "eu-central-1" });
const ddbDocClient = DynamoDBDocumentClient.from(client);

exports.handler = async (event) => {
  const id = event.title.replace(/\s+/g, '-').toLowerCase();
  const item = {
    id: id,
    title: event.title,
    watchHref: `http://www.pluralsight.com/courses/${id}`,
    authorId: event.authorId,
    length: event.length,
    category: event.category
  };

  const params = {
    TableName: "cloudtech-dev-courses",
    Item: item
  };

  try {
    await ddbDocClient.send(new PutCommand(params));
    return item;
  } catch (err) {
    console.error(err);
    throw err;
  }
};