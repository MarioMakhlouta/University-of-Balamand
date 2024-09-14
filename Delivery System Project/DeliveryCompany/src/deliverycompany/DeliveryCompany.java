/**
 * Project OOP Fall 23-24
 * Addressed to Dr. Hamid Debs
 * Program: Delivery Company Management System
 * Description: This Java program manages the operations of a Delivery Company,
 *              handling driver assignments, package and envelope deliveries.
 * Author: Mario Makhlouta
 * Date: 21/11/2023
 * 
 * This project manages the deliveries made by a delivery company.
 */

package deliverycompany;

import java.util.ArrayList; //importing the library/package to use in this Class
import java.util.Scanner;

public class DeliveryCompany{
    
    //create 2 ArrayList: Driver and DeliveryItem 
    private static ArrayList<Driver> drivers = new ArrayList();  //declare ArrayList of Driver object
    private static ArrayList<DeliveryItem> deliveries = new ArrayList(); //declare ArrayList of DeliveryItem object
    
    public static void main(String[] args){
        //create new Scanner to take inputs from user
        Scanner input = new Scanner(System.in);
        
        boolean run = true; //utily variable
        while(run){
            int choice; //user choice from the menu
            menu(); 
            System.out.print("Choose from the below Menu: ");
            choice = input.nextInt(); //take the user choice from the menu
            while(choice<1 || choice>12){
                System.out.println("\nPlease enter a valid "
                        + "choice! (Between 1 and 12)\n");
                menu();
                System.out.print("Choose from the below Menu: ");
                choice = input.nextInt(); 
            }
            System.out.println();
            switch(choice){
                
                //Add new driver:
                case 1:
                    addDriver();
                    break;
                    
                //Receive new item:
                case 2:
                    receiveItem();
                    break;  
                    
                //Display all items (received, assigned, delivered)    
                case 3:
                    displayAllItems();
                    break;
                    
                //Display all received items
                case 4:
                    displayReceivedItems();
                    break;
                
                //Display all assigned items 
                case 5:
                    displayAssignedItems();
                    break;
                    
                //Display all delivered items
                case 6:
                    displayDeliveredItems();
                    break;
                    
                //Display all drivers
                case 7:
                    displayAllDrivers();
                    break;
                    
                //Assign item to driver:
                case 8:
                    assignItem();
                    break;
                    
                //set item to received
                case 9: 
                    setItemReceived();
                    break;
                    
                //Check a driver load
                case 10:
                    checkDriverLoad();
                    break;
                
                //Display total cost
                case 11: 
                    displayTotalCost();
                    break;
                
                //Exit
                case 12: 
                    run = false;
            }
        }
    }
    
    //method to display the menu options:
    public static void menu(){
        System.out.println("1. Add new driver.");
        System.out.println("2. Receive new item.");
        System.out.println("3. Display all items "
                + "(received-assigned-delivered)");
        System.out.println("4. Display all received items.");
        System.out.println("5. Display all assigned items.");
        System.out.println("6. Display all delivered items.");
        System.out.println("7. Display all drivers.");
        System.out.println("8. Assign item to a driver.");
        System.out.println("9. Set item to received");
        System.out.println("10.Check a driver load");
        System.out.println("11.Display total cost");
        System.out.println("12.Exit");
    }
    
    //add new driver method:
    private static void addDriver(){
        // Create a new Scanner to take inputs from the user
        Scanner input = new Scanner(System.in);

        // Prompt the user to enter the characteristics of the driver
        System.out.println("Enter the characteristics of the driver: ");

        // Input the name of the driver
        System.out.print("Enter name of driver: ");
        String name = input.nextLine(); // Name of the driver
        
        // Input the car registration number of the driver
        System.out.print("Enter car registration number of driver: ");
        String carRegistrationNb = input.nextLine(); // Car registration number of the driver

        // Input the maximum weight that can be handled by the driver
        System.out.print("Enter maxWeight that can be handled "
                + "by the driver: ");
        double maxWeight = input.nextDouble(); // Maximum weight of a driver

        // Input the maximum volume that can be handled by the driver
        System.out.print("Enter maxVolume that can be handled "
                + "by the driver: ");
        double maxVolume = input.nextDouble(); // Maximum volume of a driver

        // Input the zone covered by the driver
        System.out.println("Enter the zone covered by the driver: ");
        System.out.print("Start: ");
        int zone1 = input.nextInt(); // Zone start
        System.out.print("End: ");
        int zone2 = input.nextInt(); // Zone end
        int[] zone = new int[]{zone1, zone2}; // Array to store the start and end zones

        // Create a new Driver object with the provided details
        Driver new_driver = new Driver(name, carRegistrationNb, 
                maxWeight, maxVolume, zone);

        // Add the Driver object to the ArrayList drivers
        drivers.add(new_driver);

        // Display a confirmation message after adding the new driver
        System.out.println("New driver added!\n");
    }
    
    //receive new item method:
    private static void receiveItem(){
        // Create a new Scanner to take inputs from the user
        Scanner input = new Scanner(System.in);

        // Display options for the user to choose between Envelope and Package
        System.out.println("1. Envelope\n2. Package");
        System.out.print("Enter your choice: ");
        int choice_user = input.nextInt(); // Input choice by the user

        // Validate user's choice
        while (choice_user != 1 && choice_user != 2) {
            System.out.println("Please enter a valid choice! (1 or 2)");
            System.out.print("Enter your choice: ");
            choice_user = input.nextInt();
        }

        // Input sender and receiver details for the delivery item
        System.out.print("Enter the sender name: ");
        input.nextLine(); // Clear the buffer
        String senderName = input.nextLine(); // Sender name of the DeliveryItem
        System.out.print("Enter the sender postal code: ");
        int senderPostalCode = input.nextInt(); // Sender postal code of the DeliveryItem
        input.nextLine(); // Clear the buffer
        System.out.print("Enter the receiver name: ");
        String receiverName = input.nextLine(); // Receiver name of the DeliveryItem
        System.out.print("Enter the receiver postal code: ");
        int receiverPostalCode = input.nextInt(); // Receiver postal code of the DeliveryItem

        // Input status of the item
        input.nextLine(); // Clear the buffer
        System.out.print("Enter the status of the item "
                + "(received/assigned/delivered): ");
        String status = input.nextLine(); // Status of the item
        status = status.toUpperCase(); // Convert status to uppercase

        // Input choice for insurance (Y/N)
        System.out.print("Insurance? (Y/N): ");
        char c = input.next().charAt(0); // Input choice from the user

        // Processing based on user's choice of Envelope or Package
        if (choice_user == 1) { // For an Envelope
            System.out.print("Enter size of the Envelope "
                    + "(A2, A6, A7, A9, 4square, 5square): ");
            input.nextLine(); // Clear the buffer
            String size = input.nextLine(); // Input size of the Envelope
            if (size.length() == 2) {
                size = size.toUpperCase(); // Convert size to uppercase if it's in lowercase
            }
            Envelope new_envelope = new Envelope(senderName, senderPostalCode, 
                    receiverName, receiverPostalCode, size);

            // Add insurance if chosen
            if (c == 'Y' || c == 'y') {
                new_envelope.addInsurance();
            }

            new_envelope.setStatus(status.charAt(0)); // Set the status of the item
            deliveries.add(new_envelope); // Add the Envelope object to ArrayList deliveries
        } 
        else { // For a Package
            System.out.print("Height of the Package: ");
            double height = input.nextDouble();
            System.out.print("Width of the Package: ");
            double width = input.nextDouble();
            System.out.print("Length of the Package: ");
            double length = input.nextDouble();
            System.out.print("Weight of the Package: ");
            double weight = input.nextDouble();
            Package new_package = new Package(senderName, senderPostalCode, 
                    receiverName, receiverPostalCode, 
                    height, width, length, weight);

            // Add insurance if chosen
            if (c == 'Y' || c == 'y') {
                new_package.addInsurance();
            }

            new_package.setStatus(status.charAt(0)); // Set the status of the item
            deliveries.add(new_package); // Add the Package object to ArrayList deliveries
        }

        // Display a confirmation message after adding the new item
        System.out.println("New item added!\n");
    }
    
    //method display All ietms:
    private static void displayAllItems(){
        // Check if the deliveries ArrayList is empty
        if (deliveries.isEmpty()) {
            System.out.println("No items!\n"); // Display a message if there are no items
        } else {
            // Loop through the deliveries ArrayList and display each item
            for (int i = 0; i < deliveries.size(); i++) {
                // Display each item using its toString method and add newline for separation
                System.out.println(deliveries.get(i).toString() + "\n\n");
            }
        }
    }
    
    //method display only received items:
    private static void displayReceivedItems(){
        if (deliveries.isEmpty()) {
            System.out.println("No items!\n");
        } 
        else {
            // Check if there are any received items
            boolean receivedItemsExist = false;

            // Loop through the deliveries ArrayList to find received items
            for (int i = 0; i < deliveries.size(); i++) {
                if (deliveries.get(i).getStatus() 
                        == DeliveryItem.RECEIVED) {
                    // Display details of received items and set the flag to true
                    System.out.println(deliveries
                            .get(i).toString() + "\n");
                    receivedItemsExist = true;
                }
            }

            // Check if there were no received items found
            if (!receivedItemsExist) {
                System.out.println("No received items!\n");
            }
        }
    }
    
    //method display only assigned items:
    private static void displayAssignedItems(){
        if (deliveries.isEmpty()) {
            System.out.println("No items!\n"); // Display a message if the deliveries list is empty
        } else {
            // Check if there are any assigned items
            boolean assignedItemsExist = false;

            // Loop through the deliveries ArrayList to find assigned items
            for (int i = 0; i < deliveries.size(); i++) {
                if (deliveries.get(i).getStatus() 
                        == DeliveryItem.ASSIGNED) {
                    // Display details of assigned items and set the flag to true
                    System.out.println(deliveries.
                            get(i).toString() + "\n");
                    assignedItemsExist = true;
                }
            }

            // Check if there were no assigned items found
            if (!assignedItemsExist) {
                System.out.println("No assigned items!\n");
            }
        }
    }
    
    //method display only delivered items:
    private static void displayDeliveredItems(){
        if (deliveries.isEmpty()) {
            System.out.println("No items!\n"); // Display a message if the deliveries list is empty
        } else {
            // Check if there are any delivered items
            boolean deliveredItemsExist = false;

            // Loop through the deliveries ArrayList to find delivered items
            for (int i = 0; i < deliveries.size(); i++) {
                if (deliveries.get(i).getStatus() 
                        == DeliveryItem.DELIVERED) {
                    // Display details of delivered items and set the flag to true
                    System.out.println(deliveries.get(i)
                            .toString() + "\n");
                    deliveredItemsExist = true;
                }
            }

            // Check if there were no delivered items found
            if (!deliveredItemsExist) {
                System.out.println("No delivered items!\n");
            }
        }
    }
    
    //Display all drivers method:
    private static void displayAllDrivers(){
        if (drivers.isEmpty()) {
            System.out.println("No drivers to display!"); // Display a message if the drivers list is empty
        } else {
            // Loop through the drivers ArrayList and display details of each driver
            for (int i = 0; i < drivers.size(); i++) {
                // Display details of each driver using its toString method and add newline for separation
                System.out.println(drivers.get(i).toString() + "\n\n");
            }
        }
    }
    
    //Assign item to a driver method:
    private static void assignItem(){
        // Create a new Scanner to take inputs from the user
        Scanner input = new Scanner(System.in);

        if (deliveries.isEmpty()) {
            System.out.println("No items!\n");
            if (drivers.isEmpty()) {
                System.out.println("No drivers!\n");
            }
        } 
        else if (drivers.isEmpty()) {
            System.out.println("No drivers!\n");
        } 
        else {
            int assign; // Input by user to choose an item for assignment

            if (deliveries.size() > 1) {
                // Prompt user to choose an item from the list
                System.out.print("Choose an item (1 to " 
                        + deliveries.size() + "): ");
                assign = input.nextInt();

                // Validate user input for item selection
                if (assign <= 0 || assign > deliveries.size()) {
                    System.out.println("Invalid item selection, "
                            + "please choose correctly.");
                    System.out.print("Choose an item (1 to " 
                            + deliveries.size() + "): ");
                    assign = input.nextInt();
                }
                assign--; // Adjust input to match index position in the list
            } 
            else {
                System.out.println("Only one item available!\n");
                assign = 0; // Assign the only available item
            }

            int assignTo; // Input by user to choose a driver for assignment

            if (drivers.size() > 1) {
                // Prompt user to choose a driver from the list
                System.out.print("Choose a driver (1 to " 
                        + drivers.size() + "): ");
                assignTo = input.nextInt();

                // Validate user input for driver selection
                if (assignTo <= 0 || assignTo > drivers.size()) {
                    System.out.println("Invalid driver selection, "
                            + "please choose correctly.");
                    System.out.print("Choose a driver (1 to " 
                            + drivers.size() + "): ");
                    assignTo = input.nextInt();
                }
                assignTo--; // Adjust input to match index position in the list
            } 
            else {
                System.out.println("Only one driver available!\n");
                assignTo = 0; // Assign the only available driver
            }

            // Assign the selected delivery item to the chosen driver
            drivers.get(assignTo).assignDelivery(deliveries
                    .get(assign));
            System.out.println("Assigned successfully!\n");
        }
    }
    
    //set item to received method:
    private static void setItemReceived(){
        // Create a new Scanner to take inputs from the user
        Scanner input = new Scanner(System.in);

        int item; // Input by user to choose an item

        if (!deliveries.isEmpty()) {
            if (deliveries.size() > 1) {
                // Prompt user to choose an item from the list
                System.out.print("Choose an item (1 to " 
                        + deliveries.size() + "): ");
                item = input.nextInt();

                // Validate user input for item selection
                if (item <= 0 || item > deliveries.size()) {
                    System.out.println("Invalid item selection, "
                            + "please choose correctly.");
                    System.out.print("Choose an item (1 to " 
                            + deliveries.size() + "): ");
                    item = input.nextInt();
                }
                item--; // Adjust input to match index position in the list
            } 
            else {
                System.out.println("Only one item available!\n");
                item = 0; // Assign the only available item
            }

            // Check if the selected item is already marked as received
            if (deliveries.get(item).getStatus() 
                    == DeliveryItem.RECEIVED) {
                System.out.println("Item already marked as received!\n");
            } 
            else {
                // Set the status of the selected item as "received"
                deliveries.get(item).setStatus
                                (DeliveryItem.RECEIVED);
                System.out.println("Item set as received.\n");
            }
        } 
        else {
            System.out.println("No items!\n"); // Display a message if the deliveries list is empty
        }
    }
    
    //check driver's load method:
    private static void checkDriverLoad(){
        // Create a new Scanner to take inputs from the user
        Scanner input = new Scanner(System.in);
        
        int index; // Input by user to choose a driver

        if (!drivers.isEmpty()) {
            if (drivers.size() > 1) {
                // Prompt user to choose a driver from the list
                System.out.print("Choose a driver (1 to " 
                        + drivers.size() + "): ");
                index = input.nextInt();

                // Validate user input for driver selection
                if (index <= 0 || index > drivers.size()) {
                    System.out.println("Invalid driver selection, "
                            + "please choose correctly.");
                    System.out.print("Choose a driver (1 to " 
                            + drivers.size() + "): ");
                    index = input.nextInt();
                }
                index--; // Adjust input to match index position in the list
            } 
            else {
                System.out.println("Only one driver available!\n");
                index = 0; // Assign the only available driver
            }

            // Display current weight and volume of the selected driver
            System.out.println("The driver's current weight: " 
                    + drivers.get(index).getCurrentWeight());
            System.out.println("The driver's current volume: " 
                    + drivers.get(index).getCurrentVolume());
            System.out.println();
        } 
        else {
            System.out.println("No drivers!\n"); // Display a message if the drivers list is empty
        }
    }
    
    //Total cost display method:
    private static void displayTotalCost(){
        double totalCost = 0; // Variable to store the total cost of all items

        // Loop through the deliveries ArrayList to calculate total cost
        for (int j = 0; j < deliveries.size(); j++) {
            // Accumulate the cost of each item to calculate the total cost
            totalCost += deliveries.get(j).getCost();
        }

        // Display the total cost of all items
        System.out.println("The total cost: " + totalCost);
        System.out.println();
    }
}