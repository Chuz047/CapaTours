# Capa Tours 🦜🏔️🍃

A comprehensive tourism management software, designed to optimize the administration of tours, reservations, clients, payments and
promotions. Built using C#, CSS, HTML, Javascript, Microsoft SQL Server and SCSS, this project represents a significant improvement in the administration of its tourist services, facilitating key processes such as the management of reservations, clients, payments and promotions. By optimizing these tasks, the operational burden on staff is reduced, improving efficiency.

## Features ✨🔍

### Admin Panel 🛠️📊

- **Tour Management** 🚍📅
    - 📋 **List View**: Displays all tours in a table with key details and tour status (Pending, In Progress, Completed).
    - ✏️ **Edit**: Modify existing tours using a pre-filled form.
    - ❌ **Deactivate**: Option to disable outdated or unavailable tours.
    - 🎟️ **Promotions**: Apply or remove discounts for specific tours.
- **Client Management** 👥📜
    - 📋 **List View**: Displays all registered clients in a table with key information.
    - 🚫 **Account Deactivation**: Confirmation modal to deactivate a client account.
- **Reservations Management** 📅📑
    - 📋 **List View**: Displays all reservations along with relevant details.
    - 🔎 **Filters**: Search and filter by ID/passport number.
    - 💵 **Payment Details**: Modal displaying payment information for a reservation.
    - ❌ **Cancel Reservations**: Option to manually cancel a reservation.

### Clients 👤🔑

- **Authentication** 🔐📲
    - 🔑 **Login**: Page to access the system using email and password.
    - 📄 **Registration**: Sign-up form requiring personal details.
    - 📩 **Password Recovery**: Request to reset a password via email.
- **Tour Exploration** 🌎🗺️
    - 🏠 **Home Page**: Aesthetic landing page featuring images and descriptions.
    - 📋 **Tour Listing**: View all available tours with filters for price and destination.
    - 📖 **Tour Details**: Detailed information about each tour, including ratings and reviews.
- **Reservations & Payments** 💳📝
    - 📅 **Make a Reservation**: Modal allowing users to select the number of people for a booking.
    - 📊 **Reservation Management**: Table displaying all reservations and their statuses (Pending, Confirmed, Canceled, Completed).
    - 📤 **Payments**: Modal for uploading a payment receipt and receiving a confirmation invoice via email.
- **User Interaction & Reviews** ⭐📝
    - 💬 **Review Form**: Users can rate the tour (1-5), add a title, and leave a comment.
    - 👀 **Review Display**: Reviews are publicly visible on the tour details page.

## Technologies Used 🛠️💡

- **Frontend**: CSS, HTML, JavaScript, SCSS 🌐🎨
- **Backend**: C# 💻🔙
- **Frameworks**: ASP.Net Core, Bootstrap 🖥️📚
- **Database**: Microsoft SQL Server 🗄️🔗
- **Server**: IIS Express 🔷🖥️
- **Version Control**: Git 🔂📁

## Installation 🚀⚙️

### Prerequisites 📋✅

- **Visual Studio 2022** 🖊️🖥️
- **SQL Server Management Studio** 🗄️🔍

### Setup ⚡🔧

1. **Clone the repository** 📂🔄

    ```bash
    git clone https://github.com/Chuz047/CapaTours.git
    ```

2. **Set up the Microsoft SQL Server database** 🗄️⚙️

   - 🏗️ Open **SQL Server Management Studio**.
   - 🆕 Create a new database called `CapaToursBD`.
   - 📥 Import the provided SQL file `CapaToursBD.sql` into the `CapaToursBD` database using your server.

3. **Configure the project** 📝🔧

    ```appsettings.json (Web API)

    "ConnectionStrings": {
        "BDConnection": "Server=your_server;Database=CapaTourBD;Trusted_Connection=True;TrustServerCertificate=True"
    },

    ```

4. **Start the IIS Express Server** 🚀🌐

    - 🖥️ Open the software on **Visual Studio 2022** and click on "https" for both MVC and Web API.

5. **Access the software in your browser** 🌍🔗

>[!NOTE]
>**Project Members** 🧑🏻‍💻👥
>- Esteban Roberto Quirós Martínez <br>
>- Cristopher Rodríguez Fernández <br>
>- Brenda Karina Rojas Cortés <br>
>- Paola Segura Bellanero <br>
>- Jesús Daniel Vega Marvez <br>
***
