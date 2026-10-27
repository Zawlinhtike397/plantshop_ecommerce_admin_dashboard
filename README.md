# 🌿 Plantify – Plant Shop Admin Dashboard

Plantify Admin Dashboard is a responsive Flutter Web application built to manage and monitor the Plantify plant shop e-commerce mobile app. The dashboard provides administrators with a centralized interface for managing plants, orders, discounts, and other store-related information. 

🔗 **Built admin dashboard website:**
    https://plantshopecommerceadmindashboard.vercel.app/

## 🏗️ Architecture

The project follows a **feature-first folder structure** to keep related functionality organized and make the application easier to maintain and scale.

A simplified structure:

```text
lib/
├── common/
│   ├── data_table/
│   ├── sidebar/
│   ├── dropdown/
│   └── ...
│
├── data/
│   └── repositories/
│
├── features/
│   └── authentication/
│       ├── app/
│       ├── login/
│   └── dashboard_features/
│       ├── dashboard/
│       ├── product/
│       ├── order/
│       ├── discount/
│       └── ...
│
├── routes/
│       ├── app_router.dart
│       ├── app_routes.dart
│       ├── go_router_refresh_stream.dart
│
├── validator/
│   └── ...
│
├── utils/
│   └── ...
│
└── main.dart
```

## 📸 Screenshots

  <img src="assets\screenshots\login_ss.png" />
  <img src="assets\screenshots\dashboard_ss.png" />
  <img src="assets\screenshots\products_dark_ss.png" />
  <img src="assets\screenshots\add_plant_dark.png" />
  <img src="assets\screenshots\discount_dark_ss.png" />

## 📌 Purpose

The purpose of this project is to demonstrate:

- Building a responsive Flutter Web administration dashboard
- CRUD operations for store data
- Order management workflows
- Product and discount management
- Reusable UI components
- Data tables with searching, pagination, and actions

## 🚀 Getting Started / Installation

### 1. Clone the repository

```bash
git clone https://github.com/Zawlinhtike397/plantshop_ecommerce_admin_dashboard.git 
```

### 2. Navigate to the project

```bash
cd plantfiy_plantshop_admin_dashboard
```

### 3. Open the project

```bash
code .
```

### 4. Install dependencies

```bash
flutter pub get
```

### 5. Configure environment variables

Create a `.env` file in the project root:

```env
SUPABASE_URL=your_supabase_url
SUPABASE_ANON_KEY=your_supabase_anon_key
```

### 6. Run the application

```bash
flutter run -d chrome
```

## 🚀 Tech Stack

- **Flutter** – Web application development
- **Dart** – Programming language
- **BLoC / flutter_bloc** – State management
- **Supabase** – Authentication, PostgreSQL database, and backend services
- **GoRouter** – Navigation and route management
- **flutter_dotenv** – Environment variable management
- **DataTable2** – Advanced and responsive data tables
- **CSV** – Data export functionality

## ✨ Key Features

### 📊 Dashboard
- Sales revenue chart
- Low stock alert section
- Top selling categories pie chart
- Top selling products pie chart

### 🌱 Plant Management
Administrators can manage the plants available in the Plantify store.

- View plant products
- Add new plants
- Edit existing plants
- Manage plant information
- Manage plant categories
- Manage prices
- Manage stock
- Manage plant descriptions
- Manage plant images
- Manage plant care information
- Search plants
- Export plant information as CSV

### 📦 Order Management
Administrators can monitor and manage customer orders.

- View all orders
- Search orders
- Paginate through orders
- View order details
- View customer information
- View delivery address
- View ordered products
- View order totals
- View payment method
- Update order status
- Track order progress through a timeline
- Export order information

### 🎟️ Discount / Coupon Management
Administrators can create and manage promotional discounts.

- View available coupons
- Add new discount coupons
- Search discounts
- Edit discount information
- Configure discount percentage
- Set minimum order amount
- Set expiration date
- Configure first-time-user discounts
- Activate or Deactivate discounts
- Define discount rules
- Export discount information

### 🔐 Authentication & Authorization
- Administrator login
- Authentication using Supabase Auth
- Protected dashboard routes
- Unauthorized-user handling
- Automatic redirection based on authentication state
- Environment variables for sensitive Supabase configuration

## 🧭 Navigation

The dashboard uses **GoRouter** for website navigation.

## 🌓 Theme Support

- Light theme
- Dark theme
- Responsive UI

## 🔮 Future Improvements

Possible future improvements include:

- Dashboard analytics and statistics
- More advanced role-based permissions
- Bulk product operations
- Advanced filtering and sorting
- Real-time order notifications
