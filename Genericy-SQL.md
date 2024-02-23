# Genericy-SQL ([German version below](#genericy-sql-deutsche-version))

Genericy enables seamless transformation of SQL queries into REST APIs. A powerful feature of Genericy is the support of Named Parameters in SQL statements, which provide a flexible and secure method for data manipulation. With the introduction of type specifications for these Named Parameters, developers can now further enhance data integrity. This documentation guides through the extension of Named Parameters with optional types, increasing the robustness and security of the SQL-to-REST-API transformation.

## Table of Contents

1. [Introduction to Type Extensions](#introduction-to-type-extensions)
   - [Utilization in Genericy-SQL](#utilization-in-genericy-sql)
2. [Schema and Combinatorics of Named Parameters in Genericy-SQL](#schema-and-combinatorics-of-named-parameters-in-genericy-sql)
   - [Fundamental Principles](#fundamental-principles)
   - [Type Definitions](#type-definitions)
   - [Rules for Combining Types](#rules-for-combining-types)
   - [Default Value](#default-value)
3. [Implementation of Nullable in the REST API](#implementation-of-nullable-in-the-rest-api)
   - [SELECT (GET)](#select-get)
   - [INSERT (POST) and UPDATE (PUT)](#insert-post-and-update-put)
   - [DELETE (DELETE)](#delete-delete)
4. [Clear Distinction Between Short and Long Forms with Examples](#clear-distinction-between-short-and-long-forms-with-examples)
5. [More Real-World Use Cases](#more-real-world-use-cases)
   - [Use Case 1: User Management](#use-case-1-user-management)
   - [Use Case 2: Product Search with Filters](#use-case-2-product-search-with-filters)
   - [Use Case 3: Booking and Reservation Systems](#use-case-3-booking-and-reservation-systems)
6. [Error Handling and Common Mistakes](#error-handling-and-common-mistakes)
7. [FAQ Section](#faq-section)
8. [Glossary](#glossary)

## Introduction to Type Extensions

Named Parameters in Genericy-SQL are denoted by the use of a colon (e.g., `:named_parameter`). To specify a type for such a parameter, a double underscore (`__`) followed by the type designation is appended to the parameter identifier. This extension allows for a precise definition of the data structure being received or sent via the API.

### Utilization in Genericy-SQL

Type specifications extend the capabilities of Genericy-SQL by providing type safety for the parameters of Prepared Statements. Developers can thus ensure that the data sent to or received from the database matches the expected data types. This enhances data integrity and helps avoid common sources of errors.

#### Example

```sql
SELECT * FROM users WHERE username = :username__n_S AND age > :age__n_I;
```

In this example, `:username` is defined as a nullable String, and `:age` as a nullable Integer. This ensures that the username is always a String, while the age can either be an integer or null.

## Schema and Combinatorics of Named Parameters in Genericy-SQL

The definition and use of Named Parameters in Genericy-SQL enable precise and secure handling of data within SQL-to-REST-API transformations. To ensure the integrity and clarity of these transformations, it is crucial to follow a consistent and unambiguous schema for the composition and combination of data types. The following revised guidelines provide a comprehensive overview of the correct application of type extensions for Named Parameters in Genericy.

### Fundamental Principles

1. **Consistency:** Choose either the short form or the long form for the type definition and apply it consistently throughout your project.
2. **Capitalization:** Pay attention to the precise spelling of type designations and prefixes to avoid errors.

### Type Definitions

- **Primitive Types:** Basic data types such as Strings, Numbers, Booleans, etc., are defined by simple abbreviations (S, N, I, B) or their full names (String, Number, Integer, Boolean).
- **Nullable Types:** A type can be marked as optional (nullable) by placing an `n_` (short form) or `nullable_` (long form) before the type designation.
- **Array Types:** To define arrays, `_A` (short form) or `_Array` (long form) is appended to the type designation.
- **Complex Types:**
  - **Base64 (B64):**
    - **Short Form:** `B64` is used to represent Base64-encoded data.
    - **Long Form:** `Base64` is used to clarify that the parameter should contain Base64-encoded data. Ideal for transferring files or images as part of a request.
  - **JsonObject (JO):**
    - **Short Form:** `JO` represents a JSON object.
    - **Long Form:** `JsonObject` signals that the parameter transmits complex data structures in the form of a JSON object. This allows for the transmission of structured data with key-value pairs.
  - **JsonArray (JA):**
    - **Short Form:** `JA` stands for a JSON array.
    - **Long Form:** `JsonArray` is used to indicate that the parameter transmits a list of objects or values in a JSON array. Suitable for transferring lists or collections of data in a structured form.

### Rules for Combining Types

1. **Primitive Types** form the basis of each type definition. They can be used directly or serve as the foundation for further specifications.
2. **Nullable Types** are indicated by prefixing `n_` or `nullable_` before the type. This shows that the parameter value can also be null.
3. **Array Types** are specified by appending `_A` or `_Array` to the type designation. This rule applies only to primitive types.
4. **Complex Types** such as `Base64`, `JsonObject`, and `JsonArray` can also be used to define specific data structures:
    - **Base64 (B64):** Cannot be combined with other types as it specifically stands for the encoding of binary data.
    - **JsonObject (JO):** Represents a single JSON object and is not combined with the array suffix, as it already denotes a complex, structured form of data.
    - **JsonArray (JA):** Represents a list of JSON objects or primitive types and, similar to `JsonObject`, is treated as an independent type that is not further combined with the array suffix.

### Default Value

If no type extension is specified, the type `_S` is always used as the default value.

### Implementation of Nullable in the REST API

Handling `nullable` parameters in REST APIs created with Genericy-SQL varies depending on the type of HTTP request. This section explains how `nullable` parameters are implemented in different request scenarios (`SELECT` (GET), `INSERT` (POST), `UPDATE` (PUT), and `DELETE` (DELETE)).

#### SELECT (GET)

In a `SELECT` (GET) request, Named Parameters become path variables in the URL. If a parameter is marked as `nullable`, it can be omitted from the request. In this case, the parameter's value is treated as `null`.

**Example:**

- **Without Nullable Parameter:** `/clients/user_id/123/postal_code/70176`
- **With Nullable Parameter:** `/clients/user_id/123` - Here, it's assumed that the Postal-Code parameter is `nullable` and can be omitted. The API interprets this as a search for a user with ID `123` and a `null` Postal Code, which may not be practical but illustrates the logic.

#### INSERT (POST) and UPDATE (PUT)

For `INSERT` (POST) and `UPDATE` (PUT) requests, where data is sent via the JSON-RequestBody, `nullable` parameters are considered by setting their value to JSON-`null`. This explicitly indicates that a value is not set.

**Example:**

```json
{
  "username": "newUser",
  "age": null
}
```

In this JSON-RequestBody for a POST or PUT request, the `age` parameter is set to `null` to indicate that the user's age is unknown or not applicable.

#### DELETE (DELETE)

In a `DELETE` (DELETE) request, the value `null` cannot be used since such requests must identify specific resources to be deleted. `Nullable` parameters are not applicable here since the semantics of DELETE are clearly defined, and the absence of an identifying parameter would make the request indeterminate.

### Clear Distinction Between Short and Long Forms with Examples

The distinction between short and long forms in the definition of types for Named Parameters in Genericy-SQL is crucial for maintaining the prescribed schema and ensuring clarity in SQL statements. To better understand the application and differences between these two forms, here are direct comparisons using clear examples.

#### Example 1: Standard Primitives

- **Short Form:** `:username__S`
  - Here, `username` is defined as a non-optional String.
- **Long Form:** `:username__String`
  - The long form conveys the same information but uses the full designation for the data type.

#### Example 2: Nullable Primitives

- **Short Form:** `:age__n_I`
  - This example makes `age` an optional (nullable) Integer.
- **Long Form:** `:age__nullable_Integer`
  - Again, the long form reflects the same intent but uses the full form to describe the optional nature and the data type.

#### Example 3: Arrays of Primitives

- **Short Form:** `:tags__S_A`
  - In the short form, `tags` is defined as an array of Strings.
- **Long Form:** `:tags__String_Array`
  - The long form clarifies through the detailed naming that it is an array of String values.

#### Example 4: Nullable Arrays of Primitives

- **Short Form:** `:ids__n_N_A`
  - Here, `ids` is depicted as an optional array of Numbers.
- **Long Form:**

 `:ids__nullable_Number_Array`
  - The long form clearly indicates that `ids` is an optional parameter expecting an array of Numbers.

#### Summary of Distinctions

- **Short Form:** Focuses on compactness and uses abbreviations for data types and properties (like `n_` for nullable and `_A` for arrays).
- **Long Form:** Aims for maximum clarity by using full words for types and properties (like `nullable_` for optional types and `_Array` for arrays).

The choice between short and long forms depends on the preferences of the development team and the requirements of the project. While the short form can improve the readability of complex SQL statements through brevity, the long form offers increased clarity, potentially making it more understandable for new team members or outsiders. Regardless of the chosen form, it is essential to use it consistently across the entire project to avoid misunderstandings and errors.

### More Real-World Use Cases

The use of Named Parameters with type extensions in Genericy-SQL opens up a myriad of possibilities for efficiently and securely handling complex data manipulation requirements. By integrating type information directly into the parameters, developers can create precise and robust API endpoints. The following are some real-world use cases and scenarios that highlight the flexibility and strength of the system.

#### Use Case 1: User Management

In a user management system, user data often needs to be queried based on various criteria. The ability to use Nullable and Array types simplifies handling optional filters and multiple selections.

**Example:** Querying users based on optional age and interest filters.

```sql
SELECT * FROM users
WHERE (age > :min_age__n_I OR :min_age__n_I IS NULL)
AND interests @> :interests__n_S_A;
```

In this example, `:min_age` is an optional Integer specifying the minimum age of users, and `:interests` is an optional array of Strings representing interests. The use of `n_I` and `n_S_A` allows omitting these parameters if no specific filters are to be applied.

#### Use Case 2: Product Search with Filters

E-commerce platforms often require complex search functionalities that allow filtering products by various criteria such as price, category, and ratings.

**Example:** Product search query within a price range and specific categories.

```sql
SELECT * FROM products
WHERE price BETWEEN :min_price__N AND :max_price__N
AND category_id IN (SELECT id FROM categories WHERE name = ANY(:categories__S_A));
```

Here, `:min_price` and `:max_price` define the price limits as Numbers, while `:categories` is an array of Strings indicating the names of the desired product categories. This example demonstrates how type extensions can contribute to making search queries flexible and precise.

#### Use Case 3: Booking and Reservation Systems

In booking and reservation systems, it is often necessary to transmit data that includes complex structures such as time slots, participant numbers, or special requirements.

**Example:** Creating a booking with optional participant details and special requests.

```sql
INSERT INTO bookings (date, time_slot, participants, special_requests)
VALUES (:date__S, :time_slot__S, :participants__n_I, :special_requests__n_S_A);
```

`date` and `time_slot` are Strings defining the date and time slot of the booking. `participants` is an optional Integer indicating the number of participants, and `special_requests` can be an optional array of Strings representing special requests or preferences. The use of type extensions allows for effective modeling and processing of such data structures.

### Error Handling and Common Mistakes

When working with Named Parameters and type extensions in Genericy-SQL, certain errors and misunderstandings can occur. Being aware of these pitfalls and knowing how to address them can make development more efficient and less prone to errors. Below is an overview of common sources of error and tips for their resolution.

#### Error 1: Inconsistent Type Usage

**Problem:** Mixing short and long forms within a SQL statement or project, leading to confusion or misinterpretation.

**Solution:** Decide on one of the forms (short or long) and use it consistently throughout your project. This improves readability and reduces the likelihood of errors.

#### Error 2: Incorrect Capitalization

**Problem:** Type designations and prefixes are not used precisely as prescribed, leading to syntax errors or unintended behavior.

**Solution:** Pay attention to the exact spelling of all type designations and prefixes, such as `n_` for nullable or `_A` for arrays, and strictly adhere to the guidelines regarding capitalization.

#### Error 3: Use of Unsupported Type Combinations

**Problem:** Attempting to use unsupported or nonsensical type combinations, such as an array of JsonObjects (`_JO_A`), which is not foreseen by the specification.

**Solution:** Check the documentation for supported type combinations and stick to these. Avoid inventing your own type combinations that fall outside the intended schema.

#### Error 4

: Overlooking Nullable for Optional Parameters

**Problem:** Optional parameters are defined without the Nullable prefix, potentially leading to errors when the corresponding data is not provided.

**Solution:** Always clearly mark optional parameters with `n_` or `nullable_`, ensuring that the query still functions correctly even if those data are absent.

#### Error 5: Misinterpretation of Array Parameters

**Problem:** Incorrect assumptions about the behavior of array parameters, especially the assumption that any types can be used as elements of an array.

**Solution:** Use array types only in combination with supported primitive types and ensure that the data passed to these parameters is correctly formatted (e.g., as a list of values for `_A`).

### FAQ Section

This section addresses frequently asked questions about the use of Named Parameters with type extensions in Genericy-SQL. The aim is to clarify common uncertainties and provide users with a quick reference for common problems and solution approaches.

#### Can I combine multiple types for a Named Parameter?

No, a Named Parameter can only have one specific data type plus optional modifiers such as `nullable` or `Array`. Combining different base types within a parameter is not possible. Focus on choosing the data type that best matches the data the parameter is intended to represent.

#### What happens if I don't specify a type?

If no type is specified for a Named Parameter, Genericy-SQL defaults to using the type `String` (_S). This serves as a fallback to ensure flexibility but can lead to undesired behavior in certain cases, especially if database operations require specific data types.

#### How do I handle optional parameters that are not passed?

Optional parameters should be marked with the `nullable` prefix (either `n_` in short form or `nullable_` in long form). This signals to Genericy-SQL that the parameter can be null. Ensure your SQL logic is adjusted accordingly to handle `null` values, for example, by using `IS NULL` conditions or by providing default values.

#### Can I define every data type as an array?

Yes, but only primitive types (String, Number, Integer, Boolean) and their nullable variants can be defined as an array. Complex types such as JsonObject and JsonArray cannot be used as elements of an array. Defining an array is done by appending `_A` or `_Array` to the type.

#### How are JsonObject and JsonArray used in practical scenarios?

`JsonObject` (JO) and `JsonArray` (JA) are ideal for handling complex data structures, such as configuration settings, layered information, or lists of objects. These types allow you to transmit structured data in a single parameter, which is particularly useful when receiving or sending complex data via an API.

#### Is there a limitation on the length of data I can transmit as Base64?

While Genericy-SQL does not impose specific limitations on the length of Base64-encoded strings, practical limitations may exist due to database or application logic constraints. It is advisable to consider the size limits for text fields in your database and the performance impact of very large data volumes.

#### Can I define custom data types in Genericy-SQL?

No, Genericy-SQL currently does not support custom data types. The available types are limited to the predefined basic types and their extensions. This ensures consistent data handling and simplifies the transformation of SQL queries into REST APIs.

### Glossary

Below is a glossary with definitions of specific terms and abbreviations relevant to Genericy-SQL and the use of Named Parameters with type extensions. This glossary is intended especially for beginners to better understand the fundamental concepts.

#### Array (_A / _Array)
A data type that stores an ordered collection of elements. In Genericy-SQL, arrays can be used to transmit lists of values of a specific primitive type.

#### Base64 (B64)
An encoding method that converts binary data into an ASCII string. This is useful for transmitting data such as images or documents in text form.

#### Boolean (B)
A data type that can take one of two values: true or false. Booleans are commonly used to represent yes/no or on/off states.

#### Integer (I)
A data type for whole numbers. This type is used to store and process numeric data without decimal places.

#### JsonArray (JA)
A data type that represents a list of JSON objects or values in an array format. This enables the transmission of complex or structured volumes of data.

#### JsonObject (JO)
A data type that stores data in a JSON object format. This is particularly useful for transmitting structured data with key-value pairs.

#### Named Parameter
A mechanism in SQL statements that allows the use of named variables (instead of question marks) to improve code readability and maintainability.

#### Nullable (n_ / nullable_)
A prefix used to indicate that a data type is optional and the value can be null. This is important for handling cases where data may be missing or not applicable.

#### Number (N)
A data type for numeric values that can include both whole numbers and floating-point numbers. This type is used for

 data that may be subjected to mathematical operations.

#### String (S)
A data type for text data. Strings can contain letters, numbers, and a variety of characters and are frequently used for names, descriptions, or other text-based information.

#### SQL-to-REST-API Transformation
A process where SQL queries are automatically converted into RESTful API endpoints. This allows for quick and efficient creation of APIs based on existing database structures.

# Genericy-SQL (Deutsche Version)

Genericy ermöglicht die nahtlose Transformation von SQL-Anfragen in REST-APIs. Ein leistungsstarkes Feature von Genericy ist die Unterstützung von Named Parametern in SQL-Statements, welche eine flexible und sichere Methode zur Datenmanipulation bieten. Durch die Einführung von Typangaben für diese Named Parameter können Entwickler nun die Datenintegrität weiter verbessern. Diese Dokumentation führt durch die Erweiterung der Named Parameter um optionale Typen, die die Robustheit und Sicherheit der SQL-zu-REST-API-Transformation erhöhen.

## Inhaltsverzeichnis

1. [Einführung in Typenerweiterungen](#einführung-in-typenerweiterungen)
   - [Nutzung in Genericy-SQL](#nutzung-in-genericy-sql)
2. [Schema und Kombinatorik von Named Parametern in Genericy-SQL](#schema-und-kombinatorik-von-named-parametern-in-genericy-sql)
   - [Grundprinzipien](#grundprinzipien)
   - [Typdefinitionen](#typdefinitionen)
   - [Regeln für die Kombination von Typen](#regeln-für-die-kombination-von-typen)
   - [Default-Wert](#default-wert)
3. [Implementierung von Nullable in der REST-API](#implementierung-von-nullable-in-der-rest-api)
   - [SELECT (GET)](#select-get)
   - [INSERT (POST) und UPDATE (PUT)](#insert-post-und-update-put)
   - [DELETE (DELETE)](#delete-delete)
4. [Klare Unterscheidung zwischen Kurz- und Langform anhand von Beispielen](#klare-unterscheidung-zwischen-kurz--und-langform-anhand-von-beispielen)
5. [Mehr reale Anwendungsfälle](#mehr-reale-anwendungsfälle)
   - [Anwendungsfall 1: Nutzerverwaltung](#anwendungsfall-1-nutzerverwaltung)
   - [Anwendungsfall 2: Produktsuche mit Filtern](#anwendungsfall-2-produktsuche-mit-filtern)
   - [Anwendungsfall 3: Buchungs- und Reservierungssysteme](#anwendungsfall-3-buchungs--und-reservierungssysteme)
6. [Fehlerbehandlung und häufige Fehler](#fehlerbehandlung-und-häufige-fehler)
7. [FAQ-Bereich](#faq-bereich)
8. [Glossar](#glossar)

## Einführung in Typenerweiterungen

Named Parameter in Genericy-SQL werden durch den Einsatz eines Doppelpunkts gekennzeichnet (z.B. `:named_parameter`). Um einen Typ für einen solchen Parameter festzulegen, wird dem Parameterbezeichner ein doppeltes Unterstrich (`__`) gefolgt von der Typenbezeichnung angehängt. Diese Erweiterung erlaubt eine präzise Definition der Datenstruktur, die über die API empfangen oder gesendet wird.

### Nutzung in Genericy-SQL

Die Typangaben erweitern die Möglichkeiten von Genericy-SQL, indem sie eine Typsicherheit für die Parameter von Prepared Statements bieten. Entwickler können somit sicherstellen, dass die Daten, die an die Datenbank gesendet oder von dieser empfangen werden, den erwarteten Datentypen entsprechen. Dies verbessert die Datenintegrität und hilft, häufige Fehlerquellen zu vermeiden.

#### Beispiel

```sql
SELECT * FROM users WHERE username = :username__n_S AND age > :age__n_I;
```

In diesem Beispiel wird `:username` als nullable String und `:age` als nullable Integer definiert. Dies gewährleistet, dass der Username immer ein String ist, während das Alter entweder eine Ganzzahl oder null sein kann.

## Schema und Kombinatorik von Named Parametern in Genericy-SQL

Die Definition und Verwendung von Named Parametern in Genericy-SQL ermöglicht eine präzise und sichere Handhabung von Daten innerhalb von SQL-zu-REST-API-Transformationen. Um die Integrität und Klarheit dieser Transformationen zu gewährleisten, ist es entscheidend, ein konsistentes und eindeutiges Schema für die Zusammensetzung und Kombination von Datentypen zu befolgen. Die folgenden überarbeiteten Richtlinien bieten einen umfassenden Überblick über die korrekte Anwendung von Typenerweiterungen für Named Parameter in Genericy.

### Grundprinzipien

1. **Konsistenz:** Wählen Sie entweder die Kurzform oder die Langform für die Typdefinition und wenden Sie diese durchgehend an.
2. **Groß- und Kleinschreibung:** Beachten Sie die genaue Schreibweise der Typkennzeichnungen und Präfixe, um Fehler zu vermeiden.

### Typdefinitionen

- **Primitive Typen:** Basisdatentypen wie Strings, Zahlen, Booleans etc. werden durch einfache Kürzel (S, N, I, B) oder ihre vollständigen Namen (String, Number, Integer, Boolean) definiert.
- **Nullable Typen:** Ein Typ kann als optional (nullable) gekennzeichnet werden, indem ein `n_` (Kurzform) oder `nullable_` (Langform) vor die Typbezeichnung gesetzt wird.
- **Array Typen:** Um Arrays zu definieren, wird `_A` (Kurzform) oder `_Array` (Langform) an die Typbezeichnung angehängt.
- **Komplexe Typen:**
  - **Base64 (B64):**
    - **Kurzform:** `B64` dient zur Darstellung von Base64-kodierten Daten.
    - **Langform:** `Base64` wird verwendet, um klarzustellen, dass der Parameter Base64-kodierte Daten enthalten soll. Ideal für die Übertragung von Dateien oder Bildern als Teil einer Anfrage.
  - **JsonObject (JO):**
    - **Kurzform:** `JO` repräsentiert ein JSON-Objekt.
    - **Langform:** `JsonObject` signalisiert, dass der Parameter komplexe Datenstrukturen in Form eines JSON-Objekts übermittelt. Dies ermöglicht die Übertragung strukturierter Daten mit Schlüssel-Wert-Paaren.
  - **JsonArray (JA):**
    - **Kurzform:** `JA` steht für ein JSON-Array.
    - **Langform:** `JsonArray` wird genutzt, um anzugeben, dass der Parameter eine Liste von Objekten oder Werten in einem JSON-Array übermittelt. Geeignet für die Übertragung von Listen oder Sammlungen von Daten in strukturierter Form.

### Regeln für die Kombination von Typen

1. **Primitive Typen** bilden die Grundlage jeder Typdefinition. Sie können direkt verwendet oder als Basis für weitere Spezifikationen dienen.
2. **Nullable Typen** werden durch Voranstellen von `n_` oder `nullable_` vor den Typ definiert. Dies zeigt an, dass der Parameterwert auch null sein kann.
3. **Array-Typen** werden durch Anhängen von `_A` oder `_Array` an die Typbezeichnung angegeben. Diese Regel gilt nur für primitive Typen.
4. **Komplexe Typen** wie `Base64`, `JsonObject`, und `JsonArray` können ebenfalls verwendet werden, um spezifische Datenstrukturen zu definieren:
    - **Base64 (B64):** Kann nicht mit anderen Typen kombiniert werden, da es spezifisch für die Kodierung von Binärdaten steht.
    - **JsonObject (JO):** Repräsentiert ein einzelnes JSON-Objekt und wird nicht mit dem Array-Suffix kombiniert, da es bereits eine komplexe, strukturierte Datenform darstellt.
    - **JsonArray (JA):** Repräsentiert eine Liste von JSON-Objekten oder primitiven Typen und wird, ähnlich wie `JsonObject`, als eigenständiger Typ behandelt, der nicht weiter mit dem Array-Suffix kombiniert wird.

### Default-Wert

Wird keine Typerweiterung angegeben, so wird immer der Typ `_S` als Default-Wert verwendet.

### Implementierung von Nullable in der REST-API

Die Handhabung von `nullable` Parametern in REST-APIs, die mit Genericy-SQL erstellt wurden, variiert je nach Typ der HTTP-Anfrage. Dieser Abschnitt erläutert, wie `nullable` Parameter in verschiedenen Anfrageszenarien (`SELECT` (GET), `INSERT` (POST), `UPDATE` (PUT) und `DELETE` (DELETE)) implementiert werden.

#### SELECT (GET)

Bei einer `SELECT` (GET)-Anfrage werden Named Parameter zu Pfadvariablen in der URL. Wenn ein Parameter als `nullable` markiert ist, kann er in der Anfrage weggelassen werden. In diesem Fall wird der Wert des Parameters als `null` behandelt.

**Beispiel:**

- **Ohne Nullable Parameter:** `/clients/user_id/123/postal_code/70176`
- **Mit Nullable Parameter:** `/clients/user_id/123` - Hier wird davon ausgegangen, dass der Postal-Code-Parameter `nullable` ist und weggelassen werden kann. Die API interpretiert dies als eine Suche nach einem Benutzer mit der ID `123` und einem `null` Postal Code, was in der Praxis vielleicht nicht sinnvoll ist, aber die Logik verdeutlicht.

#### INSERT (POST) und UPDATE (PUT)

Für `INSERT` (POST) und `UPDATE` (PUT)-Anfragen, bei denen Daten über den JSON-RequestBody gesendet werden, werden `nullable` Parameter berücksichtigt, indem ihr Wert auf JSON-`null` gesetzt wird. Dies gibt explizit an, dass ein Wert nicht festgelegt ist.

**Beispiel:**

```json
{
  "username": "neuerBenutzer",
  "age": null
}
```

In diesem JSON-RequestBody für eine POST- oder PUT-Anfrage wird der `age`-Parameter auf `null` gesetzt, um anzugeben, dass das Alter des Benutzers unbekannt oder nicht zutreffend ist.

#### DELETE (DELETE)

Bei einer `DELETE` (DELETE)-Anfrage kann der Wert `null` nicht verwendet werden, da solche Anfragen spezifische Ressourcen identifizieren müssen, die gelöscht werden sollen. `Nullable` Parameter sind hier nicht anwendbar, da die Semantik von DELETE klar definiert ist und das Fehlen eines identifizierenden Parameters die Anfrage unbestimmt machen würde.

### Klare Unterscheidung zwischen Kurz- und Langform anhand von Beispielen

Die Unterscheidung zwischen Kurz- und Langform bei der Definition von Typen für Named Parameter in Genericy-SQL ist entscheidend für die Einhaltung des vorgegebenen Schemas und die Gewährleistung der Klarheit in SQL-Statements. Um die Anwendung und die Unterschiede zwischen diesen beiden Formen besser zu verstehen, werden hier direkte Vergleiche anhand eindeutiger Beispiele vorgestellt.

#### Beispiel 1: Standardprimitive

- **Kurzform:** `:username__S`
  - Hier wird `username` als ein nicht-optionaler String definiert.
- **Langform:** `:username__String`
  - Die Langform bietet dieselbe Information, verwendet jedoch die vollständige Bezeichnung für den Datentyp.

#### Beispiel 2: Nullable Primitive

- **Kurzform:** `:age__n_I`
  - Dieses Beispiel macht `age` zu einem optionalen (nullable) Integer.
- **Langform:** `:age__nullable_Integer`
  - Auch hier spiegelt die Langform die gleiche Intention wider, nutzt jedoch die ausgeschriebene Form, um die Optionaleigenschaft und den Datentyp zu beschreiben.

#### Beispiel 3: Array von Primitiven

- **Kurzform:** `:tags__S_A`
  - In der Kurzform wird `tags` als ein Array von Strings definiert.
- **Langform:** `:tags__String_Array`
  - Die Langform verdeutlicht durch die ausführliche Benennung, dass es sich um ein Array von String-Werten handelt.

#### Beispiel 4: Nullable Array von Primitiven

- **Kurzform:** `:ids__n_N_A`
  - Hier wird `ids` als ein optionales Array von Zahlen (Numbers) dargestellt.
- **Langform:** `:ids__nullable_Number_Array`
  - Die Langform erklärt deutlich, dass `ids` ein optionaler Parameter ist, der ein Array von Zahlen erwartet.

#### Zusammenfassung der Unterscheidungen

- **Kurzform:** Fokussiert auf die Kompaktheit und verwendet Abkürzungen für Datentypen und Eigenschaften (wie `n_` für nullable und `_A` für Arrays).
- **Langform:** Zielt auf maximale Klarheit ab, indem vollständige Wörter für Typen und Eigenschaften verwendet werden (wie `nullable_` für optionale Typen und `_Array` für Arrays).

Die Wahl zwischen Kurz- und Langform hängt von den Präferenzen des Entwicklerteams und den Anforderungen des Projekts ab. Während die Kurzform die Lesbarkeit von komplexen SQL-Statements durch Kürze verbessern kann, bietet die Langform eine erhöhte Klarheit und kann insbesondere für neue Teammitglieder oder Außenstehende leichter verständlich sein. Unabhängig von der gewählten Form ist es wesentlich, diese konsistent über das gesamte Projekt hinweg zu nutzen, um Missverständnisse und Fehler zu vermeiden.

### Mehr reale Anwendungsfälle

Die Verwendung von Named Parametern mit Typenerweiterungen in Genericy-SQL eröffnet eine Vielzahl von Möglichkeiten, um komplexe Datenmanipulationsanforderungen effizient und sicher zu handhaben. Durch die Integration von Typinformationen direkt in die Parameter können Entwickler präzise und robuste API-Endpunkte erstellen. Im Folgenden werden einige reale Anwendungsfälle und Szenarien vorgestellt, die die Flexibilität und Stärke des Systems aufzeigen.

#### Anwendungsfall 1: Nutzerverwaltung

In einem System zur Nutzerverwaltung müssen oft Nutzerdaten basierend auf verschiedenen Kriterien abgefragt werden. Die Möglichkeit, Nullable- und Array-Typen zu verwenden, erleichtert die Handhabung optionaler Filter und Mehrfachauswahlen.

**Beispiel:** Abfrage von Nutzern basierend auf optionalen Alters- und Interessensfiltern.

```sql
SELECT * FROM users
WHERE (age > :min_age__n_I OR :min_age__n_I IS NULL)
AND interests @> :interests__n_S_A;
```

In diesem Beispiel ist `:min_age` ein optionaler Integer, der das Mindestalter der Nutzer angibt, und `:interests` ist ein optionales Array von Strings, das die Interessen repräsentiert. Die Verwendung von `n_I` und `n_S_A` ermöglicht es, diese Parameter wegzulassen, wenn keine entsprechenden Filter angewendet werden sollen.

#### Anwendungsfall 2: Produktsuche mit Filtern

E-Commerce-Plattformen benötigen oft komplexe Suchfunktionen, die es ermöglichen, Produkte nach verschiedenen Kriterien wie Preis, Kategorie und Bewertungen zu filtern.

**Beispiel:** Suchanfrage für Produkte innerhalb einer Preisspanne und bestimmten Kategorien.

```sql
SELECT * FROM products
WHERE price BETWEEN :min_price__N AND :max_price__N
AND category_id IN (SELECT id FROM categories WHERE name = ANY(:categories__S_A));
```

Hier definiert `:min_price` und `:max_price` die Preisgrenzen als Numbers, während `:categories` ein Array von Strings ist, das die Namen der gewünschten Produktkategorien enthält. Dieses Beispiel zeigt, wie die Typenerweiterungen dazu beitragen können, Suchanfragen flexibel und präzise zu gestalten.

#### Anwendungsfall 3: Buchungs- und Reservierungssysteme

In Systemen für Buchungen und Reservierungen ist es oft erforderlich, Daten zu übermitteln, die komplexe Strukturen wie Zeitfenster, Teilnehmerzahlen oder spezielle Anforderungen umfassen.

**Beispiel:** Erstellung einer Buchung mit optionalen Teilnehmerdetails und speziellen Anforderungen.

```sql
INSERT INTO bookings (date, time_slot, participants, special_requests)
VALUES (:date__S, :time_slot__S, :participants__n_I, :special_requests__n_S_A);
```

`date` und `time_slot` sind Strings, die Datum und Zeitfenster der Buchung definieren. `participants` ist ein optionaler Integer, der die Anzahl der Teilnehmer angibt, und `special_requests` kann ein optionales Array von Strings sein, das spezielle Anforderungen oder Wünsche enthält. Durch die Verwendung von Typenerweiterungen können solche Datenstrukturen effektiv modelliert und verarbeitet werden.

### Fehlerbehandlung und häufige Fehler

Bei der Arbeit mit Named Parametern und Typenerweiterungen in Genericy-SQL können bestimmte Fehler und Missverständnisse auftreten. Ein Bewusstsein für diese Fallstricke und das Wissen, wie man sie behebt, kann die Entwicklung effizienter und weniger fehleranfällig machen. Im Folgenden finden Sie eine Übersicht über häufige Fehlerquellen und Tipps zu deren Behebung.

#### Fehler 1: Inkonsistente Typverwendung

**Problem:** Mischung von Kurz- und Langform innerhalb eines SQL-Statements oder Projekts, was zu Verwirrung oder Fehlinterpretationen führen kann.

**Lösung:** Entscheiden Sie sich für eine der Formen (Kurz- oder Langform) und verwenden Sie diese konsistent in Ihrem gesamten Projekt. Dies verbessert die Lesbarkeit und verringert die Wahrscheinlichkeit von Fehlern.

#### Fehler 2: Falsche Groß- und Kleinschreibung

**Problem:** Typkennzeichnungen und Präfixe werden nicht genau wie vorgeschrieben verwendet, was zu Syntaxfehlern oder unbeabsichtigtem Verhalten führen kann.

**Lösung:** Achten Sie auf die exakte Schreibweise aller Typkennzeichnungen und Präfixe, wie `n_` für nullable oder `_A` für Arrays, und halten Sie sich strikt an die Vorgaben bezüglich Groß- und Kleinschreibung.

#### Fehler 3: Verwendung nicht unterstützter Typkombinationen

**Problem:** Versuch, nicht unterstützte oder nicht sinnvolle Typkombinationen zu verwenden, wie beispielsweise ein Array von JsonObjects (`_JO_A`), was von der Spezifikation nicht vorgesehen ist.

**Lösung:** Überprüfen Sie die Dokumentation auf unterstützte Typkombinationen und beschränken Sie sich auf diese. Vermeiden Sie es, eigene Typkombinationen zu erfinden, die außerhalb des vorgesehenen Schemas liegen.

#### Fehler 4: Übersehen von Nullable bei optionalen Parametern

**Problem:** Optionale Parameter werden ohne das Nullable-Präfix definiert, was zu Fehlern führen kann, wenn die entsprechenden Daten nicht übermittelt werden.

**Lösung:** Kennzeichnen Sie optionale Parameter immer deutlich mit `n_` oder `nullable_`, um sicherzustellen, dass die Abfrage auch dann korrekt funktioniert, wenn diese Daten nicht vorhanden sind.

#### Fehler 5: Fehlinterpretation von Array-Parametern

**Problem:** Falsche Annahme über das Verhalten von Array-Parametern, insbesondere die Annahme, dass beliebige Typen als Elemente eines Arrays verwendet werden können.

**Lösung:** Verwenden Sie Array-Typen nur in Kombination mit unterstützten primitiven Typen und stellen Sie sicher, dass die Daten, die an diese Parameter übergeben werden, korrekt formatiert sind (z.B. als Liste von Werten für `_A`).

### FAQ-Bereich

In diesem Abschnitt werden häufig gestellte Fragen rund um die Nutzung von Named Parametern mit Typenerweiterungen in Genericy-SQL behandelt. Ziel ist es, verbreitete Unsicherheiten zu klären und Anwendern eine schnelle Referenz für gängige Probleme und Lösungsansätze zu bieten.

#### Kann ich mehrere Typen für einen Named Parameter kombinieren?

Nein, ein Named Parameter kann nur einen spezifischen Datentyp plus optionale Modifikatoren wie `nullable` oder `Array` haben. Die Kombination unterschiedlicher Basistypen innerhalb eines Parameters ist nicht möglich. Konzentrieren Sie sich darauf, den Datentyp zu wählen, der am besten zu den Daten passt, die der Parameter repräsentieren soll.

#### Was passiert, wenn ich einen Typ nicht spezifiziere?

Wenn kein Typ für einen Named Parameter spezifiziert wird, verwendet Genericy-SQL standardmäßig den Typ `String` (_S). Dies dient als Fallback, um die Flexibilität zu gewährleisten, kann aber in bestimmten Fällen zu unerwünschtem Verhalten führen, insbesondere wenn die Datenbankoperationen spezifische Datentypen erfordern.

#### Wie gehe ich mit optionalen Parametern um, die nicht übergeben werden?

Optionale Parameter sollten mit dem `nullable` Präfix (entweder `n_` in der Kurzform oder `nullable_` in der Langform) gekennzeichnet werden. Dies signalisiert Genericy-SQL, dass der Parameter null sein kann. Stellen Sie sicher, dass Ihre SQL-Logik entsprechend angepasst ist, um mit `null` Werten umzugehen, zum Beispiel durch Verwendung von `IS NULL` Bedingungen oder durch Bereitstellung von Default-Werten.

#### Kann ich jeden Datentyp als Array definieren?

Ja, aber nur primitive Typen (String, Number, Integer, Boolean) und ihre nullable Varianten können als Array definiert werden. Komplexe Typen wie JsonObject und JsonArray können nicht als Elemente eines Arrays verwendet werden. Die Definition eines Arrays erfolgt durch Anhängen von `_A` oder `_Array` an den Typ.

#### Wie werden JsonObject und JsonArray in praktischen Szenarien verwendet?

`JsonObject` (JO) und `JsonArray` (JA) sind ideal für den Umgang mit komplexen Datenstrukturen, wie Konfigurationseinstellungen, mehrschichtigen Informationen oder Listen von Objekten. Diese Typen ermöglichen es Ihnen, strukturierte Daten in einem einzigen Parameter zu übermitteln, was besonders nützlich ist, wenn Sie über eine API komplexe Daten empfangen oder senden müssen.

#### Gibt es eine Beschränkung für die Länge der Daten, die ich als Base64 übermitteln kann?

Während Genericy-SQL keine spezifischen Beschränkungen für die Länge von Base64-kodierten Strings auferlegt, können praktische Limitierungen durch die Datenbank oder die Anwendungslogik bestehen. Es ist ratsam, die Größenbeschränkungen für Textfelder in Ihrer Datenbank und die Performance-Impakt von sehr großen Datenmengen zu berücksichtigen.

#### Kann ich benutzerdefinierte Datentypen in Genericy-SQL definieren?

Nein, Genericy-SQL unterstützt derzeit keine benutzerdefinierten Datentypen. Die verfügbaren Typen sind auf die vorgegebenen Basistypen und ihre Erweiterungen beschränkt. Dies gewährleistet eine konsistente Handhabung der Daten und vereinfacht die Transformation von SQL-Anfragen in REST-APIs.

### Glossar

Im Folgenden finden Sie ein Glossar mit Definitionen spezifischer Begriffe und Abkürzungen, die im Kontext von Genericy-SQL und der Verwendung von Named Parametern mit Typenerweiterungen relevant sind. Dieses Glossar soll insbesondere Anfängern helfen, die grundlegenden Konzepte besser zu verstehen.

#### Array (_A / _Array)
Ein Datentyp, der eine geordnete Sammlung von Elementen speichert. In Genericy-SQL können Arrays verwendet werden, um Listen von Werten eines bestimmten primitiven Typs zu übermitteln.

#### Base64 (B64)
Ein Kodierungsverfahren, das binäre Daten in eine ASCII-Zeichenkette umwandelt. Dies ist nützlich, um Daten wie Bilder oder Dokumente in Textform zu übermitteln.

#### Boolean (B)
Ein Datentyp, der einen von zwei Werten annehmen kann: wahr (true) oder falsch (false). Booleans werden häufig verwendet, um Ja/Nein- oder Ein/Aus-Zustände zu repräsentieren.

#### Integer (I)
Ein Datentyp für ganze Zahlen. Dieser Typ wird verwendet, um numerische Daten ohne Dezimalstellen zu speichern und zu verarbeiten.

#### JsonArray (JA)
Ein Datentyp, der eine Liste von JSON-Objekten oder Werten in einem Array-Format darstellt. Dies ermöglicht die Übermittlung komplexer oder strukturierter Datenmengen.

#### JsonObject (JO)
Ein Datentyp, der Daten in einem JSON-Objektformat speichert. Dies ist besonders nützlich für die Übermittlung von strukturierten Daten mit Schlüssel-Wert-Paaren.

#### Named Parameter
Ein Mechanismus in SQL-Statements, der es ermöglicht, Variablen mit Namen (anstelle von Fragezeichen) zu verwenden, um die Lesbarkeit und Wartbarkeit von Code zu verbessern.

#### Nullable (n_ / nullable_)
Ein Präfix, das verwendet wird, um anzugeben, dass ein Datentyp optional ist und der Wert null sein kann. Dies ist wichtig für die Behandlung von Fällen, in denen Daten möglicherweise fehlen oder nicht anwendbar sind.

#### Number (N)
Ein Datentyp für numerische Werte, der sowohl ganze Zahlen als auch Fließkommazahlen umfassen kann. Dieser Typ wird für Daten verwendet, die mathematischen Operationen unterzogen werden könnten.

#### String (S)
Ein Datentyp für Textdaten. Strings können Buchstaben, Zahlen und eine Vielzahl von Zeichen enthalten und werden häufig für Namen, Beschreibungen oder andere textbasierte Informationen verwendet.

#### SQL-zu-REST-API-Transformation
Ein Prozess, bei dem SQL-Abfragen automatisch in RESTful API-Endpunkte umgewandelt werden. Dies ermöglicht eine schnelle und effiziente Erstellung von APIs basierend auf vorhandenen Datenbankstrukturen.
