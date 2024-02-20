<p align="left">
  <a href="https://www.genericy.de" target="_blank"><img src="https://www.genericy.de/wp-content/uploads/2024/01/Genericy-Logo.png" width="200" alt="Genericy"></a>
</p>

# Getting Started

## English (German version below)

Welcome to Genericy, the new era of database integration. Revolutionize your database operations with SQL to REST API transformation. Genericy enables rapid REST API development and deployment by automatically converting SQL statements into endpoints and generating OpenAPI documentation.

### Prerequisites
- Docker and Docker Compose installed. [Install Docker](https://docs.docker.com/get-docker/) and [Docker Compose](https://docs.docker.com/compose/install/)
- A license file, which must be obtained from the Genericy website: [https://www.genericy.de](https://www.genericy.de)

### Steps to Get Started with a SQLite Sample Database
1. Clone this repository and switch to the directory:
```
git clone https://github.com/SpicetechGmbH/Genericy-Getting-Started.git
cd Genericy-Getting-Started
```
2. Download a sample database:
```
curl -L -o Chinook_Sqlite.sqlite https://github.com/lerocha/chinook-database/releases/download/v1.4.5/Chinook_Sqlite.sqlite
```

3. The `license.lic` file will be delivered to you via email. Place it in the same folder as the `genericy.jar` file and pay close attention to the exact spelling of the filename `license.lic`.

4. Optionally, you can adjust the port, to which the service is bound on the host machine, in the `docker-compose.yml` file. By default, the port is set to 8888.

5. Execute `docker-compose up`.

6. Copy the admin key that is displayed in the Docker console.
   <img width="1912" alt="Bildschirmfoto 2024-02-20 um 10 57 57" src="https://github.com/SpicetechGmbH/Genericy-Getting-Started/assets/37299230/48535d34-3be6-4623-b170-0a565a635294">

8. Open `http://localhost:8888/genericy/admin.html` in your browser, insert the admin key, and click LOGIN.
   <img width="1912" alt="Bildschirmfoto 2024-02-20 um 10 41 15" src="https://github.com/SpicetechGmbH/Genericy-Getting-Started/assets/37299230/05a35d85-4af7-4972-92b4-573e27b31740">

10. Optionally, you can add sample endpoints from the SETTINGS menu.

    - Click on SETTINGS
    <img width="1912" alt="Bildschirmfoto 2024-02-20 um 10 41 30" src="https://github.com/SpicetechGmbH/Genericy-Getting-Started/assets/37299230/d3f9128f-7cbd-4b31-a9ed-b6d7c7a944b0">

    - Click on LOAD SAMPLE STATEMENTS
    <img width="1912" alt="Bildschirmfoto 2024-02-20 um 10 41 43" src="https://github.com/SpicetechGmbH/Genericy-Getting-Started/assets/37299230/ea20648b-7240-4ff2-9860-ce04a2238475">

    - Click on CONFIRM
    <img width="1912" alt="Bildschirmfoto 2024-02-20 um 10 41 55" src="https://github.com/SpicetechGmbH/Genericy-Getting-Started/assets/37299230/fd7b19d0-f32f-436d-8fb6-9512fe6fd2b2">

    - Click on SQL-EDITOR to get back
    <img width="1912" alt="Bildschirmfoto 2024-02-20 um 10 42 14" src="https://github.com/SpicetechGmbH/Genericy-Getting-Started/assets/37299230/2e33657f-428c-4bcc-bb91-101ecab5ac84">

Now you can work the sample data and create your own Genericy statements.

In the next step, the sample database can be replaced with an existing target database. The configuration must be adjusted as described in the following section.

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

---

## Deutsch

Willkommen bei Genericy, dem neuen Zeitalter der Datenbankintegration. Revolutionieren Sie Ihre Datenbankoperationen mit der SQL-zu-REST-API-Transformation. Genericy ermöglicht die schnelle Entwicklung und Bereitstellung von REST-APIs, indem SQL-Anweisungen automatisch in Endpunkte umgewandelt und OpenAPI-Dokumentationen generiert werden.

### Voraussetzungen
- Docker und Docker-Compose installiert. [Docker installieren](https://docs.docker.com/get-docker/) und [Docker-Compose installieren](https://docs.docker.com/compose/install/)
- Eine Lizenzdatei, die von der Genericy-Website bezogen werden muss: [https://www.genericy.de](https://www.genericy.de)

### Schritte zum Einstieg mit einer SQLite-Beispieldatenbank
1. Klonen Sie dieses Repository und wechseln Sie in das Verzeichnis:
```
git clone https://github.com/SpicetechGmbH/Genericy-Getting-Started.git
cd Genericy-Getting-Started
```
2. Laden Sie eine Beispiel-Datenbank herunter:
```
curl -L -o Chinook_Sqlite.sqlite https://github.com/lerocha/chinook-database/releases/download/v1.4.5/Chinook_Sqlite.sqlite
```

3. Die Datei `license.lic` wird Ihnen per E-Mail zugestellt. Legen Sie sie in denselben Ordner wie die `genericy.jar`-Datei und achten Sie auf die exakte Schreibweise des Dateinamens `license.lic`.

4. Optional: Sie können den Port, an den der Dienst auf dem Hostrechner gebunden wird, in der `docker-compose.yml`-Datei anpassen. Standardmäßig ist der Port auf 8888 eingestellt.

5. Führen Sie `docker-compose up` aus.

6. Kopieren Sie den Admin-Key, der in der Docker-Konsole ausgegeben wird.
   <img width="1912" alt="Bildschirmfoto 2024-02-20 um 10 57 57" src="https://github.com/SpicetechGmbH/Genericy-Getting-Started/assets/37299230/4536ec51-48d7-4098-98d0-c68fd4e3d9f1">

8. Öffnen Sie `http://localhost:8888/genericy/admin.html` in Ihrem Browser, fügen Sie den Admin-Key ein und klicken Sie auf LOGIN.
   <img width="1798" alt="Bildschirmfoto 2024-02-20 um 10 29 08" src="https://github.com/SpicetechGmbH/Genericy-Getting-Started/assets/37299230/d6f1be74-54bc-4373-9116-45a10fbdb739">

10. Optional: Sie können Beispiel-Endpoints im Menü unter SETTINGS hinzufügen.
    
    - KLicken Sie auf SETTINGS
    <img width="1912" alt="Bildschirmfoto 2024-02-20 um 10 41 30" src="https://github.com/SpicetechGmbH/Genericy-Getting-Started/assets/37299230/d3f9128f-7cbd-4b31-a9ed-b6d7c7a944b0">

    - Klicken Sie auf LOAD SAMPLE STATEMENTS
    <img width="1912" alt="Bildschirmfoto 2024-02-20 um 10 41 43" src="https://github.com/SpicetechGmbH/Genericy-Getting-Started/assets/37299230/ea20648b-7240-4ff2-9860-ce04a2238475">

    - Klicken Sie auf CONFIRM
    <img width="1912" alt="Bildschirmfoto 2024-02-20 um 10 41 55" src="https://github.com/SpicetechGmbH/Genericy-Getting-Started/assets/37299230/fd7b19d0-f32f-436d-8fb6-9512fe6fd2b2">

    - KLicken Sie auf SQL-EDITOR um zurückzukehren
    <img width="1912" alt="Bildschirmfoto 2024-02-20 um 10 42 14" src="https://github.com/SpicetechGmbH/Genericy-Getting-Started/assets/37299230/2e33657f-428c-4bcc-bb91-101ecab5ac84">

Nun können Sie mit den Beispieldaten arbeiten und Ihre eigenen Genericy-Statements erstellen.

Im nächsten Schritt kann die Beispieldatenbank durch eine existierende Ziel-Datenbank ersetzt werden. Die Konfiguration muss wie im folgenden Abschnitt beschrieben angepasst werden.

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

[Impress/Impressum](https://www.spicetech.de/#Impressum)
