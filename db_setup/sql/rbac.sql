set role docker;

-- Create roles
create role airbyte_role; 
create role dagster_role;

-- Create users 
create user airbyte_user with password 'airbyte';
create user dagster_user with password 'dagster';

-- Revoke permissions
revoke all on schema public from public;
revoke all on database raw, dagster from public;

-- Grant roles
grant airbyte_role to airbyte_user;
grant dagster_role to dagster_user; 

-- Database permissions
grant create, temporary on database raw to airbyte_role; 
grant create, temporary on database dagster to dagster_role;

-- Create separate schemas
create schema dagster.dagster;
create schema raw.airbyte;

-- Set default schemas for role simplification 
alter user dagster_user set search_path to dagster.dagster;
alter user airbyte_user set search_path to airbyte.airbyte;