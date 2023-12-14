#!/bin/bash

# Set PostgreSQL variables
PGUSER="docker"
PGPASSWORD="docker"

# Connect to PostgreSQL and execute commands
PGPASSWORD=docker psql -h localhost -p 5432 -U docker postgres -c "
-- Superuser
-- Create roles
CREATE ROLE airbyte_role; 
CREATE ROLE dagster_role;

-- Create users 
CREATE USER airbyte_user WITH PASSWORD 'airbyte';
CREATE USER dagster_user WITH PASSWORD 'dagster';

-- Grant roles
GRANT airbyte_role TO airbyte_user;
GRANT dagster_role TO dagster_user; 

-- Database permissions
GRANT CONNECT, CREATE, TEMPORARY ON DATABASE raw TO airbyte_role; 
GRANT CONNECT, CREATE, TEMPORARY ON DATABASE dagster TO dagster_role;

-- Revoke permissions
--REVOKE ALL ON DATABASE raw, dagster FROM public;
"

PGPASSWORD=docker psql -h localhost -p 5432 -U docker dagster -c "
-- Create separate schema
CREATE SCHEMA dagster;

-- Set default schema for role simplification 
--ALTER USER dagster_user SET search_path TO dagster;
"

PGPASSWORD=docker psql -h localhost -p 5432 -U docker raw -c "
-- Create separate schema
CREATE SCHEMA raw;

-- Set default schema for role simplification 
--ALTER USER airbyte_user SET search_path TO raw;
"
