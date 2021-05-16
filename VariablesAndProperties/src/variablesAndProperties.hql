-- Set variables and properties for a given hive session --

-- hivevar --
-- before initiating shell --
-- hive --define databaseName=Person

-- inside hive shell --
set hivevar:databaseName=Person;
-- print hivevar --
set hivevar:databaseName;

-- hiveconf --
-- before initiating shell --
-- hive --hiveconf hive.cli.print.current.db=true

-- inside hive shell --
set hive.cli.print.current.db=true;
-- print hiveconf --
set hive.cli.print.current.db;

-- system (Java system variables) --
-- inside hive shell --
set system:user.name=ved;
-- print system --
set system:user.name;

-- env (System env variables) --
-- inside hive shell --
set env:HIVE_HOME_DEMO=/usr/local/hive;
-- print env --
set env:HIVE_HOME_DEMO;
