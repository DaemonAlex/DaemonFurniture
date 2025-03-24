# DaemonFurniture  WIP 
Furniture Store and Manufacturing Business for QBX/QB core

# Furniture Store System for OBX-core

A comprehensive furniture store system for OBX-core that features both a buyer-side catalog and a builder-side order queue. Buyers can browse available furniture items with pictures and prices by interacting with a store prop using **ox_target** and **ox_lib**. Builders can view pending orders and mark them as complete, with the entire process being managed via server-side order tracking.

## Features

- **Buyer Catalog:**  
  - Interactive store prop that opens a visual catalog when a player approaches.
  - Displays furniture items with images, prices, and details.
  - Buyers can place orders directly from the catalog.

- **Builder Order Queue:**  
  - Pending orders are stored on the server.
  - Builders can use a dedicated command to view and process pending orders.
  - Order status updates notify both buyers and builders.

- **Customizable Configuration:**  
  - Easily add or modify furniture recipes, including ingredients, prices, and images.
  - Supports both cloth and leather versions for select items.
  - Designed to integrate seamlessly with OBX-core.

## Requirements

- [OBX-core](https://github.com/your-obx-core-repo) *(replace with the appropriate link)*
- [ox_lib](https://github.com/overextended/ox_lib)
- [ox_target](https://github.com/overextended/ox_target)

## Installation

1. **Clone or download** this repository into your server's `resources` folder.
2. **Add the resource** to your server configuration file (`server.cfg`):
   ```ini
   ensure furniture_store
