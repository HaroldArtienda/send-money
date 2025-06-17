#!/bin/bash

# Move to project root
cd "$(dirname "$0")/.."

echo ""
echo "📦 Running build_runner..."
flutter pub run build_runner build --delete-conflicting-outputs
if [ $? -ne 0 ]; then
  echo ""
  echo "❌ build_runner failed. Fix issues first."
  exit 1
fi

echo ""
echo "✅ build_runner complete."

echo ""
echo "🧪 Running tests..."
flutter test
if [ $? -ne 0 ]; then
  echo ""
  echo "❌ Some tests failed."
  exit 1
fi

echo ""
echo "✅ All tests passed."
