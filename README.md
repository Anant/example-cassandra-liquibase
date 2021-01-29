# Liquibase-and-Cassandra
In this repository, we will discuss how to connect Liquibase with Apache Cassandra and DataStax Astra.
</br>
</br>
We recommend first trying out the method with Gitpod and DataStax Astra as with this method you will not have to do any manual local installations and you can get a free managed Cassandra instance in the cloud. Hit the button below to get started!
</br>
</br>
[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/adp8ke/Liquibase-and-Cassandra) 
</br>
</br>
We will also cover how to use Liquibase locally with local Cassandra and Astra. 
</br>
</br>
Additional Resources can be found at the end of the repo!
</br>
</br>

## Gitpod and DataStax Astra
### Gitpod Setup
1. Open this repo in Gitpod
2. Run the following commands to make a liquibase directory, download liquibase into it, and add liquibase to PATH
```bash
mkdir liquibase
curl -L -s https://github.com/liquibase/liquibase/releases/download/v4.2.2/liquibase-4.2.2.tar.gz | tar xvz -C /workspace/Liquibase-and-Cassandra/liquibase
export PATH=$PATH:/workspace/Liquibase-and-Cassandra/liquibase
```
3. Run the following commands to change the Gitpod's Java version to 1.8. You may run into timeout errors using the latest Java version, so we will set it to 1.8, which was indicated by the Liquibase team. When prompted to set the installed java version as default, select YES. 
```bash
sdk install java 8.0.275.open-adpt
```
4. Confirm Java version is now 1.8
```bash
java -version
```
5. Download prerequisite JARs to talk to Cassandra and store them in `/liquibase/lib`
```bash
wget -P /workspace/Liquibase-and-Cassandra/liquibase/lib https://github.com/liquibase/liquibase-cassandra/releases/download/liquibase-cassandra-4.2.2/liquibase-cassandra-4.2.2.jar
wget https://downloads.datastax.com/jdbc/cql/2.0.4.1004/SimbaCassandraJDBC42-2.0.4.1004.zip && unzip SimbaCassandraJDBC42-2.0.4.1004.zip -d /workspace/Liquibase-and-Cassandra/liquibase/lib && rm SimbaCassandraJDBC42-2.0.4.1004.zip
```
### Using Liquibase with Astra on Gitpod
1. Rename astra.liquibase.properties to liquibase.properties
```bash
mv astra.liquibase.properties liquibase.properties
```
2. Download Secure Connect Bundle from DataStax Astra for your database and drag-and-drop it into the root level of the workspace
3. Unzip a copy of the downloaded Secure Connect Bundle and open the config.json file in a code editor.
4. Update host, keyspace and port with the values from your config.json file. Replace UID and PWD with the databases username and password that you set. Also update the database name for `SecureConnectionBundlePath=secure-connect-<your-database>.zip` to match the zip file you drag-and-dropped into Gitpod
```bash
vim liquibase.properties
```
5. Run liquibase status to confirm that unadded changesets are being seen
```bash
liquibase status
```
6. Run liquibase update to run changeset
```bash
liquibase update
```
7. Open DataStax Astra Studio to confirm that there are 3 new tables
- leaves_by_tag
- databasechangelog
- databasechangeloglock
8. Change `liquibase.properties` file to now use `dbchangelog.xml`
```bash
vim liquibase.properties
```
9. Run `liquibase status` again to confirm that there are now 2 new changesets that have not been run
```bash
liquibase status
```
10. Run `liquibase update` to introduce the new changesets
```bash
liquibase update
```
11. With Astra Studio, confirm there are now 3 records in the `databasechangelog` table and there is now a `tags` table
12. Run a rollback to revert a migration using the tag we introduced in changeset 2
```bash
liquibase rollback version_1.0.1
```
13. With Astra studio, confirm rollback occured by seeing that the tags table is now gone and the dbchangelog table has been updated.

### Local Liquibase with Apache Cassadndra and DataStax Astra
## Local setup
1. Download Liquabase with the installer for your machine or use the tar.gz and then add liquibase to PATH
2. Download the prerequisite JARs and place them into the `path/to/liquibase/lib` directory
- [Simba JDBC](https://downloads.datastax.com/#odbc-jdbc-drivers)
- [liquibase-cassandra](https://github.com/liquibase/liquibase-cassandra/releases/)
3. If you run into timeout errors, update your Java version to 1.8 from the version that it is currently on

### Using Liquibase with Apahche Cassandra Locally
1. Rename astra.liquibase.properties to liquibase.properties
```bash
mv cassandra.liquibase.properties liquibase.properties
```
2. Update the keyspace placeholder value with your specific keyspace
```bash
vim liquibase.properties
```
3. Run liquibase status to confirm that unadded changesets are being seen
```bash
liquibase status
```
4. Run liquibase update to run changeset
```bash
liquibase update
```
5. Open CQLSH to to confirm that there are 3 new tables
- leaves_by_tag
- databasechangelog
- databasechangeloglock
6. Change `liquibase.properties` file to now use `dbchangelog.xml`
```bash
vim liquibase.properties
```
7. Run `liquibase status` again to confirm that there are now 2 new changesets that have not been run
```bash
liquibase status
```
8. Run `liquibase update` to introduce the new changesets
```bash
liquibase update
```
9. Using CQLSH, confirm there are now 3 records in the `databasechangelog` table and there is now a `tags` table
10. Run a rollback to revert a migration using the tag we introduced in changeset 2
```bash
liquibase rollback version_1.0.1
```
11. Confirm with CQLSH that the rollback occured by seeing that the tags table is now gone and the dbchangelog table has been updated.

### Using Liquibase with Astra Locally
1. Rename astra.liquibase.properties to liquibase.properties
```bash
mv astra.liquibase.properties liquibase.properties
```
2. Download Secure Connect Bundle from DataStax Astra for your database and drag-and-drop it into the root level of the directory
3. Unzip a copy of the downloaded Secure Connect Bundle and open the config.json file in a code editor.
4. Update host, keyspace and port with the values from your config.json file. Replace UID and PWD with the databases username and password that you set. Also update the database name for `SecureConnectionBundlePath=secure-connect-<your-database>.zip` to match the zip file you drag-and-dropped into Gitpod
```bash
vim liquibase.properties
```
5. Run liquibase status to confirm that unadded changesets are being seen
```bash
liquibase status
```
6. Run liquibase update to run changeset
```bash
liquibase update
```
7. Open DataStax Astra Studio to confirm that there are 3 new tables
- leaves_by_tag
- databasechangelog
- databasechangeloglock
8. Change `liquibase.properties` file to now use `dbchangelog.xml`
```bash
vim liquibase.properties
```
9. Run `liquibase status` again to confirm that there are now 2 new changesets that have not been run
```bash
liquibase status
```
10. Run `liquibase update` to introduce the new changesets
```bash
liquibase update
```
11. With Astra Studio, confirm there are now 3 records in the `databasechangelog` table and there is now a `tags` table
12. Run a rollback to revert a migration using the tag we introduced in changeset 2
```bash
liquibase rollback version_1.0.1
```
13. With Astra studio, confirm rollback occured by seeing that the tags table is now gone and the dbchangelog table has been updated.

## Additional Resources:
- [Webinar with Live Demo]
- [Accompanying Blog]
- [Accompanying SlideShare]
- [Cassandra Setup Docs](https://docs.liquibase.com/workflows/database-setup-tutorials/cassandra.html?Highlight=cassandra)
- [Liquibase’s Blog on Liquibase and Cassandra (dockerized)](https://www.liquibase.org/blog/running-liquibase-apache-cassandra)
- [Astra Setup Docs](https://docs.liquibase.com/workflows/database-setup-tutorials/cassandra-astra.html?Highlight=cassandra)
