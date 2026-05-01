const { DynamoDBClient } = require("@aws-sdk/client-dynamodb");
const { DynamoDBDocumentClient, PutCommand } = require("@aws-sdk/lib-dynamodb");

const client = new DynamoDBClient({ region: "eu-central-1" });
const ddbDocClient = DynamoDBDocumentClient.from(client);

exports.handler = async (event) => {
  const params = {
    TableName: "cloudtech-dev-courses",
    Item: event // Приймає повний об'єкт курсу з ID
  };

  try {
    await ddbDocClient.send(new PutCommand(params));
    return event;
  } catch (err) {
    console.error(err);
    throw err;
  }
};