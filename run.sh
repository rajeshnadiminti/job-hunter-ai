#!/bin/bash
# Job Hunter AI — Quick Setup & Run
# Usage: chmod +x run.sh && ./run.sh

set -e

echo ""
echo "═══════════════════════════════════════════════════"
echo "  JOB HUNTER AI — Setup & Launch"
echo "═══════════════════════════════════════════════════"
echo ""

# Check Python
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 not found. Install from https://python.org"
    exit 1
fi
echo "✓ Python found: $(python3 --version)"

# Create venv if it doesn't exist
if [ ! -d "venv" ]; then
    echo "→ Creating virtual environment..."
    python3 -m venv venv
fi

# Activate venv
source venv/bin/activate
echo "✓ Virtual environment activated"

# Install deps
echo "→ Installing dependencies..."
pip install -q -r requirements.txt
echo "✓ Dependencies installed"

# Create uploads dir
mkdir -p uploads

echo ""
echo "═══════════════════════════════════════════════════"
echo "  Starting server..."
echo "  Open: http://localhost:5000"
echo "  Stop: Ctrl+C"
echo "═══════════════════════════════════════════════════"
echo ""

python3 app.py
