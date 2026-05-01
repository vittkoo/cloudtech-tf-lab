const { DynamoDBClient } = require("@aws-sdk/client-dynamodb");
const { DynamoDBDocumentClient, DeleteCommand } = require("@aws-sdk/lib-dynamodb");

const client = new DynamoDBClient({ region: "eu-central-1" });
const ddbDocClient = DynamoDBDocumentClient.from(client);

exports.handler = async (event) => {
  const params = {
    TableName: "cloudtech-dev-courses",
    Key: { id: event.id }
  };

  try {
    await ddbDocClient.send(new DeleteCommand(params));
    return { id: event.id, message: "Deleted successfully" };
  } catch (err) {
    console.error(err);
    throw err;
  }
};