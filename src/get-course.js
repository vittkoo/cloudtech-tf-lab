const { DynamoDBClient } = require("@aws-sdk/client-dynamodb");
const { DynamoDBDocumentClient, GetCommand } = require("@aws-sdk/lib-dynamodb");

const client = new DynamoDBClient({ region: "eu-central-1" });
const ddbDocClient = DynamoDBDocumentClient.from(client);

exports.handler = async (event) => {
  const params = {
    TableName: "cloudtech-dev-courses",
    Key: { id: event.id }
  };

  try {
    const data = await ddbDocClient.send(new GetCommand(params));
    return data.Item;
  } catch (err) {
    console.error(err);
    throw err;
  }
};