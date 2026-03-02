## AWS Serverless Patterns

### Lambda Handlers
- Handlers are thin orchestrators — delegate business logic to services/use cases
- Never put business logic directly in the handler
- Always return proper API Gateway response format: `{ statusCode, headers, body }`
- Set `JSON.stringify()` on the body, not the entire response
- Handle errors with try/catch at the handler level, return appropriate status codes

### Cold Starts
- Keep handler files small — avoid heavy top-level imports
- Initialize SDK clients outside the handler (module scope) for connection reuse
- Avoid importing the entire AWS SDK — use individual service clients:
  ```typescript
  // Good
  import { DynamoDBClient } from '@aws-sdk/client-dynamodb';
  // Bad
  import AWS from 'aws-sdk';
  ```
- Use provisioned concurrency for latency-sensitive endpoints

### DynamoDB
- Always use parameterized expressions — never concatenate user input into queries
- Design access patterns first, then model the table (single-table design preferred)
- Use `ExpressionAttributeNames` and `ExpressionAttributeValues` for all queries
- Prefer `query` over `scan` — scans consume capacity on the entire table
- Handle `ConditionalCheckFailedException` explicitly for conditional writes

### Environment Variables
- Access all config through a centralized constants file, never `process.env` directly in business logic
- Required env vars should be validated at cold start, not at request time
- Use SSM Parameter Store or Secrets Manager for sensitive values, not plain env vars

### Error Handling
- Wrap all handler logic in try/catch
- Log the full error object for debugging, return sanitized message to client
- Use structured logging (JSON format) for CloudWatch queryability
- Never expose stack traces or internal paths in API responses

### Infrastructure as Code
- serverless.yml / SAM template defines all resources
- Never create resources manually in AWS Console
- Use stage variables for environment-specific config: `${self:provider.stage}`
- Tag all resources with service name and environment
