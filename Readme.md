<p align="left">
  <a href="https://www.genericy.de" target="_blank"><img src="https://www.genericy.de/wp-content/uploads/2024/01/Genericy-Logo.png" width="200" alt="Genericy"></a>
</p>

# Getting Started

## English (German version below)

Welcome to Genericy, the new era of database integration. Revolutionize your database operations with SQL to REST API transformation. Genericy enables rapid REST API development and deployment by automatically converting SQL statements into endpoints and generating OpenAPI documentation.

### Prerequisites
- Docker and Docker Compose installed. [Install Docker](https://docs.docker.com/get-docker/) and [Docker Compose](https://docs.docker.com/compose/install/)

### Steps to Get Started with a SQLite Sample Database

1. **Clone the Repository and Navigate:**
   ```
   git clone https://github.com/SpicetechGmbH/Genericy-Getting-Started.git
   cd Genericy-Getting-Started
   ```

2. **Optionally Adjust Port Settings:**
   If needed, modify the port to which the service binds on the host machine in the `docker-compose.yml` file. By default, it's set to 8888.

3. **Start Genericy and Download Sample Database:**
   Run `docker-compose up` to initiate Genericy. During this step, a sample SQLite database named `Chinook_Sqlite.sqlite` will be downloaded if it doesn't already exist.

4. **Copy the Admin Key:**
   Copy the admin key displayed in the Docker console.
   ![Admin Key Screenshot](https://github.com/SpicetechGmbH/Genericy-Getting-Started/assets/37299230/48535d34-3be6-4623-b170-0a565a635294)

5. **Access the Admin Interface:**
   Open [http://localhost:8888/genericy/admin.html](http://localhost:8888/genericy/admin.html) in your browser, paste the admin key, and click LOGIN.
   ![Admin Interface Screenshot](https://github.com/SpicetechGmbH/Genericy-Getting-Started/assets/37299230/05a35d85-4af7-4972-92b4-573e27b31740)

6. **Optional: Add Sample Endpoints:**
   You can add sample endpoints from the SETTINGS menu.

7. **Activate License and Explore:**
   After accepting the license agreement, new users can request a 30-day free demo license. Now you can work with the sample data and create your own Genericy statements. For more information about Genericy-SQL, refer to the [Genericy-SQL Documentation](Genericy-SQL.md) in the same repository.

8. **Replace Sample Database (Optional):**
   In the next step, you can replace the sample database with an existing target database. Follow the configuration adjustments described in the subsequent section.

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

### Schritte zum Starten mit einer SQLite-Beispieldatenbank

1. **Repository klonen und Verzeichnis wechseln:**
   ```
   git clone https://github.com/SpicetechGmbH/Genericy-Getting-Started.git
   cd Genericy-Getting-Started
   ```

2. **Optional: Porteinstellungen anpassen:**
   Bei Bedarf können Sie den Port, an den der Dienst auf dem Hostrechner gebunden ist, in der Datei `docker-compose.yml` ändern. Standardmäßig ist er auf 8888 festgelegt.

3. **Genericy starten und Beispieldatenbank herunterladen:**
   Führen Sie `docker-compose up` aus, um Genericy zu starten. Während dieses Schritts wird eine Beispieldatenbank im SQLite-Format namens `Chinook_Sqlite.sqlite` heruntergeladen, falls sie noch nicht vorhanden ist.

4. **Admin-Key kopieren:**
   Kopieren Sie den in der Docker-Konsole angezeigten Admin-Key.
   ![Screenshot des Admin-Schlüssels](https://github.com/SpicetechGmbH/Genericy-Getting-Started/assets/37299230/48535d34-3be6-4623-b170-0a565a635294)

5. **Zugriff auf die Admin-Oberfläche:**
   Öffnen Sie [http://localhost:8888/genericy/admin.html](http://localhost:8888/genericy/admin.html) in Ihrem Browser, fügen Sie den Admin-Key ein und klicken Sie auf LOGIN.
   ![Screenshot der Admin-Oberfläche](https://github.com/SpicetechGmbH/Genericy-Getting-Started/assets/37299230/05a35d85-4af7-4972-92b4-573e27b31740)

6. **Optional: Beispiel-Endpunkte hinzufügen:**
   Sie können im SETTINGS-Menü Beispiel-Endpunkte hinzufügen.

7. **Lizenz aktivieren und erkunden:**
   Nachdem Sie die Lizenzvereinbarung akzeptiert haben, können neue Benutzer eine kostenlose 30-tägige Demo-Lizenz anfordern. Jetzt können Sie mit den Beispieldaten arbeiten und Ihre eigenen Genericy-Anweisungen erstellen. Weitere Informationen zu Genericy-SQL finden Sie in der [Genericy-SQL-Dokumentation](Genericy-SQL.md) im selben Repository.

8. **Beispieldatenbank ersetzen (optional):**
   Im nächsten Schritt können Sie die Beispieldatenbank durch eine vorhandene Ziel-Datenbank ersetzen. Folgen Sie hierzu den Konfigurationsanpassungen, welche im folgenden Abschnitt beschrieben sind.

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
