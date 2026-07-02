#!/bin/bash

###############################################################################
# ABC-Technologies
#
# Build Script
#
# Purpose:
# Builds the Java application using Maven.
#
###############################################################################

set -e

echo "========================================================="
echo " ABC-Technologies - Build Started"
echo "========================================================="

echo ""
echo "Cleaning previous build..."
mvn clean

echo ""
echo "Compiling source code..."
mvn compile

echo ""
echo "Running unit tests..."
mvn test

echo ""
echo "Packaging application..."
mvn package

echo ""
echo "Build completed successfully."

echo ""
echo "Generated artifact:"
ls -lh target/*.war

echo ""
echo "========================================================="
echo " Build Finished Successfully"
echo "========================================================="