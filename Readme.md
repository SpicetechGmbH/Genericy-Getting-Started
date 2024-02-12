### README.md

---

# Genericy: Getting Started

## English (German version below)

Welcome to Genericy, the new era of database integration. Revolutionize your database operations with SQL to REST API transformation. Genericy enables rapid REST API development and deployment by automatically converting SQL statements into endpoints and generating OpenAPI documentation.

### Prerequisites
- Docker and Docker Compose installed. [Install Docker](https://docs.docker.com/get-docker/) and [Docker Compose](https://docs.docker.com/compose/install/)
- A license file, which must be obtained from the Genericy website: [https://www.genericy.de](https://www.genericy.de)

### Configuration
The `application.properties` file contains configuration settings for connecting your database to Genericy. Here's what each setting means:

- `genericy.target-db.jdbc-url`: JDBC URL of the target database for Genericy to apply and provide endpoints. It specifies the database type, host, port, and database name.

- `genericy.target-db.username`: Username for accessing the target database.

- `genericy.target-db.password`: Password for accessing the target database.

- `genericy.target-db.driver-class-name`: Class name of the JDBC driver used for connecting to the target database. Genericy currently supports:
  - MySQL: `com.mysql.cj.jdbc.Driver`
  - MariaDB: `org.mariadb.jdbc.Driver`
  - PostgreSQL: `org.postgresql.Driver`
  - SQLite: `org.sqlite.JDBC`

- `genericy.config-db.jdbc-url`: JDBC URL for Genericy's own configuration database, which can be the same as or separate from the target database.

- `genericy.config-db.username`: Username for accessing the configuration database.

- `genericy.config-db.password`: Password for accessing the configuration database.

- `genericy.config-db.driver-class-name`: Class name of the JDBC driver for the configuration database, supporting the same drivers as the target database.

### Steps to Get Started
1. Clone this repository.
2. Configure the `application.properties` file with your database details.
3. Obtain the `licence.lic` file from [https://www.genericy.de](https://www.genericy.de) and place it in the same folder as the `genericy.jar` file.
4. Optionally, adjust the ports in the `docker-compose` file.
5. Run `docker-compose up`.
6. Open `http://localhost:8888` in your browser.

## Deutsch

Willkommen bei Genericy, dem neuen Zeitalter der Datenbankintegration. Revolutionieren Sie Ihre Datenbankoperationen mit der SQL-zu-REST-API-Transformation. Genericy ermöglicht die schnelle Entwicklung und Bereitstellung von REST-APIs, indem SQL-Anweisungen automatisch in Endpunkte umgewandelt und OpenAPI-Dokumentationen generiert werden.

### Voraussetzungen
- Docker und Docker-Compose installiert. [Docker installieren](https://docs.docker.com/get-docker/) und [Docker-Compose installieren](https://docs.docker.com/compose/install/)
- Eine Lizenzdatei, die von der Genericy-Website bezogen werden muss: [https://www.genericy.de](https://www.genericy.de)

### Konfiguration
Die Datei `application.properties` enthält Konfigurationseinstellungen für die Verbindung Ihrer Datenbank mit Genericy. Hier die Bedeutung jeder Einstellung:

- `genericy.target-db.jdbc-url`: JDBC-URL der Ziel-Datenbank, auf die Genericy angewendet wird, um Endpunkte bereitzustellen. Sie gibt den Datenbanktyp, Host, Port und den Namen der Datenbank an.

- `genericy.target-db.username`: Benutzername für den Zugriff auf die Ziel-Datenbank.

- `genericy.target-db.password`: Passwort für den Zugriff auf die Ziel-Datenbank.

- `genericy.target-db.driver-class-name`: Klassenname des JDBC-Treibers, der für die Verbindung zur Ziel-Datenbank verwendet wird. Genericy unterstützt derzeit:
  - MySQL: `com.mysql.cj.jdbc.Driver`
  - MariaDB: `org.mariadb.jdbc.Driver`
  - PostgreSQL: `org.postgresql.Driver`
  - SQLite: `org.sqlite.JDBC`

- `genericy.config-db.jdbc-url`: JDBC-URL für die Konfigurationsdatenbank von Genericy, die gleich oder getrennt von der Ziel-Datenbank sein kann.

- `genericy.config-db.username`: Benutzername für den Zugriff auf die Konfigurationsdatenbank.

- `genericy.config-db.password`: Passwort für den Zugriff auf die Konfigurationsdatenbank.

- `genericy.config-db.driver-class-name`: Klassenname des JDBC-Treibers für die Konfigurationsdatenbank, unterstützt die gleichen Treiber wie die Ziel-Datenbank.

### Schritte zum E

instieg
1. Dieses Repository klonen.
2. Konfigurieren Sie die `application.properties` Datei mit Ihren Datenbankdetails.
3. Beziehen Sie die Datei `licence.lic` von [https://www.genericy.de](https://www.genericy.de) und legen Sie sie in denselben Ordner wie die Datei `genericy.jar`.
4. Optional können Sie die Ports in der Datei `docker-compose` anpassen.
5. Führen Sie `docker-compose up` aus.
6. Öffnen Sie `http://localhost:8888` in Ihrem Browser.

[Impress/Impressum](https://www.spicetech.de/#Impressum)
