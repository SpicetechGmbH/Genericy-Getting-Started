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

Sie haben bereits einen ausgezeichneten Rahmen für die README.md sowohl in Englisch als auch in Deutsch erstellt. Um die Konfigurationserweiterung für die OpenAPI-Dokumentation zu integrieren, füge ich den entsprechenden Abschnitt in beide Sprachversionen ein:

### Additional Configuration for OpenAPI Documentation

To ensure the OpenAPI documentation functions correctly and is accessible from outside the container, you need to specify the external URL through which the container will be accessed. Add the following line to your `application.properties` file:

- `genericy.allowed-origins=http://localhost:8888`

This setting should match the URL you use to access the Genericy container from your browser. Adjust the URL accordingly if your setup differs.

### Important Note for SQLite Users

If you are using SQLite as your database with Genericy, it is crucial to stop the Genericy service before making any changes to the SQLite database. SQLite locks the database file during write operations, which means that no changes can be made to the database while Genericy is running. To ensure data integrity and prevent potential data loss or corruption, please follow these steps:

- If you started the Genericy service with the `-d` option (detached mode), stop the service by running `docker-compose down` in the terminal where your Genericy Docker container is running.
- If you started the service without the `-d` option, simply press `Ctrl-C` in the terminal to stop the service.

After stopping the service:
1. Make the necessary changes to your SQLite database.
2. Restart the Genericy service by running `docker-compose up` (add `-d` if you wish to run it in detached mode again).

This procedure ensures that your database changes are safely applied, and Genericy can continue to operate smoothly with the updated database.

### Steps to Get Started
1. Clone this repository.
2. Configure the `application.properties` file with your database details.
3. Obtain the `licence.lic` file from [https://www.genericy.de](https://www.genericy.de) and place it in the same folder as the `genericy.jar` file.
4. Optionally, adjust the ports in the `docker-compose` file.
5. Run `docker-compose up`.
6. Open `http://localhost:8888` in your browser.

---

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

### Zusätzliche Konfiguration für OpenAPI-Dokumentation

Um sicherzustellen, dass die OpenAPI-Dokumentation korrekt funktioniert und von außerhalb des Containers zugänglich ist, müssen Sie die externe URL angeben, über die auf den Container zugegriffen wird. Fügen Sie folgende Zeile zu Ihrer `application.properties`-Datei hinzu:

- `genericy.allowed-origins=http://localhost:8888`

Diese Einstellung sollte der URL entsprechen, die Sie verwenden, um auf den Genericy-Container von Ihrem Browser aus zuzugreifen. Passen Sie die URL entsprechend an, falls Ihre Einrichtung abweicht.

### Wichtiger Hinweis für SQLite-Benutzer

Wenn Sie SQLite als Datenbank zusammen mit Genericy verwenden, ist es entscheidend, den Genericy-Dienst zu stoppen, bevor Änderungen an der SQLite-Datenbank vorgenommen werden. SQLite sperrt die Datenbankdatei während Schreiboperationen, was bedeutet, dass keine Änderungen an der Datenbank vorgenommen werden können, solange Genericy läuft. Um die Datenintegrität zu gewährleisten und möglichen Datenverlust oder -korruption zu verhindern, folgen Sie bitte diesen Schritten:

- Wenn Sie den Genericy-Dienst mit der Option `-d` (Detached-Modus) gestartet haben, stoppen Sie den Dienst, indem Sie `docker-compose down` im Terminal ausführen, in dem Ihr Genericy Docker-Container läuft.
- Wenn Sie den Dienst ohne die `-d` Option gestartet haben, drücken Sie einfach `Ctrl-C` im Terminal, um den Dienst zu stoppen.

Nachdem der Dienst gestoppt wurde:
1. Nehmen Sie die notwendigen Änderungen an Ihrer SQLite-Datenbank vor.
2. Starten Sie den Genericy-Dienst neu, indem Sie `docker-compose up` ausführen (fügen Sie `-d` hinzu, wenn Sie ihn erneut im Detached-Modus ausführen möchten).

Durch das Befolgen dieses Verfahrens stellen Sie sicher, dass Ihre Datenbankänderungen sicher angewendet werden und dass Genericy reibungslos mit der aktualisierten Datenbank weiterarbeiten kann.

### Schritte zum Einstieg
1. Dieses Repository klonen.
2. Konfigurieren Sie die `application.properties` Datei mit Ihren Datenbankdetails.
3. Beziehen Sie die Datei `licence.lic` von [https://www.genericy.de](https://www.genericy.de) und legen Sie sie in denselben Ordner wie die Datei `genericy.jar`.
4. Optional können Sie die Ports in der Datei `docker-compose` anpassen.
5. Führen Sie `docker-compose up` aus.
6. Öffnen Sie `http://localhost:8888` in Ihrem Browser.

[Impress/Impressum](https://www.spicetech.de/#Impressum)
