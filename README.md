# Driving & Vehicle License Department (DVLD) System

A comprehensive Windows-based desktop application designed to automate the workflows and operations of a driving license department[cite: 1]. The system handles the complete lifecycle of driving licenses, core applications, multi-stage examination scheduling, and database-driven system administration[cite: 1].

> **Project Status:** 🚧 *Under Development / Code Refactoring*
> I am currently refactoring the core codebase to optimize database queries, implement advanced T-SQL practices, and apply advanced data structures for enhanced in-memory data processing.

---

## 🏗️ Architecture & Design

The application is built using a strict **3-Tier Architecture** pattern to ensure clean separation of concerns, maintainability, and scalability:
1. **Presentation Layer (UI):** Built with Windows Forms (WinForms), capturing user inputs and rendering dynamic data dynamically.
2. **Business Logic Layer (BLL):** Handles all validation rules, business logic enforcement, and operational logic before data persistence.
3. **Data Access Layer (DAL):** Manages direct communication with the database using ADO.NET for efficient data retrieval and manipulation.

---

## 🚀 Key Features

### 📋 Application & License Management
* **Multi-Service Licensing:** Supports 7 main services including New Local Licenses, Renewals, Replacements (Lost/Damaged), International Licenses, and Retest requests[cite: 1].
* **Dynamic License Classes:** Enforces distinct business rules for 7 different license classes, validating parameters like minimum age, fee structures, and validity periods automatically[cite: 1].
* **Business Rule Validation:** Prevents duplicate active applications or licenses of the same class for any single individual based on their unique National Number[cite: 1].

### 📑 Sequential Examination Workflow
* **Three-Stage Test Flow:** Manages a strict sequence of examinations: **Vision Test ➡️ Theory Test ➡️ Practical Driving Test**[cite: 1].
* **Prerequisite Logic:** Automatically blocks users from booking or advancing to the next examination tier unless they have successfully passed and paid for the preceding stage[cite: 1].

### 🔒 Administration & Security
* **User & Access Management:** Provides full CRUD operations for managing system users, including account status locking and customized application permissions[cite: 1].
* **Detain & Release System:** Includes a dedicated module to handle traffic violations by detaining licenses, calculating penalties, and tracking structural releases upon fine payments[cite: 1].
* **Transaction Logging (Audit Trail):** Enforces accountability by automatically logging the exact User ID and Timestamp for every critical movement or record modification within the system[cite: 1].

---

## 🛠️ Tech Stack

* **Language:** C#
* **Framework:** .NET Framework / .NET Core (WinForms)
* **Database:** Microsoft SQL Server
* **Database Language:** T-SQL (Stored Procedures, Views, Triggers, and Transactions)
* **Data Access:** ADO.NET
