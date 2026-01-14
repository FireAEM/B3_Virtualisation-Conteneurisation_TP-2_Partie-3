#!/bin/bash

HOST=${1:-localhost}

echo "Running integration tests against $HOST..."

echo "Testing /health..."
curl -f http://$HOST/health || exit 1

echo "Testing /..."
response=$(curl -s http://$HOST/)
if echo "$response" | grep -q "Hello from CI/CD"; then
  echo "Main endpoint OK"
else
  echo "Main endpoint failed"
  exit 1
fi

echo "Testing response time..."
time=$(curl -o /dev/null -s -w '%{time_total}\n' http://$HOST/)
if (( $(echo "$time < 1.0" | bc -l) )); then
  echo "Response time OK: ${time}s"
else
  echo "Slow response: ${time}s"
fi

echo "All tests passed!"
