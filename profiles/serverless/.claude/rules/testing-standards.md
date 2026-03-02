## Testing Standards (Serverless)

### Unit Tests
- Test business logic (services/use cases) independently from AWS infrastructure
- Mock all AWS SDK calls — never make real API calls in tests
- Use `jest.mock()` for SDK clients, not actual DynamoDB/S3/SNS connections
- Test handler response format: `{ statusCode, headers, body }`
- Test error paths: invalid input, missing resources, permission errors

### Mocking AWS Services
```typescript
// Mock DynamoDB
const mockSend = jest.fn();
jest.mock('@aws-sdk/client-dynamodb', () => ({
  DynamoDBClient: jest.fn(() => ({ send: mockSend })),
  GetItemCommand: jest.fn(),
  PutItemCommand: jest.fn(),
}));
```

### Test File Naming
- `*.test.ts` matching source file names
- Place tests in `test/` directory mirroring `src/` structure
- `test/unit/` for unit tests, `test/integration/` for integration tests

### Coverage
- Focus on business logic coverage, not infrastructure glue
- Handler tests should verify request/response mapping
- Service tests should verify business rules and edge cases
