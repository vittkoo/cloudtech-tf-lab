const { DynamoDBClient } = require("@aws-sdk/client-dynamodb");
const { DynamoDBDocumentClient, ScanCommand } = require("@aws-sdk/lib-dynamodb");

const client = new DynamoDBClient({ region: "eu-central-1" }); // Твій регіон
const ddbDocClient = DynamoDBDocumentClient.from(client);

exports.handler = async () => {
  const params = { TableName: "cloudtech-dev-authors" };
  try {
    const data = await ddbDocClient.send(new ScanCommand(params));
    return data.Items; // Повертає чистий масив об'єктів
  } catch (err) {
    console.error(err);
    throw err;
  }
};