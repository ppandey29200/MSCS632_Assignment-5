#include <iostream>
#include <vector>
#include <memory>

using namespace std;

// --------- Ride Base Class ---------
class Ride {
protected:
    int rideID;
    string pickupLocation;
    string dropoffLocation;
    double distance;

public:
    Ride(int id, string pickup, string dropoff, double dist)
        : rideID(id), pickupLocation(pickup), dropoffLocation(dropoff), distance(dist) {}

    virtual double fare() const = 0; // pure virtual method

    virtual void rideDetails() const {
        cout << "Ride ID: " << rideID << "\nPickup: " << pickupLocation
             << "\nDropoff: " << dropoffLocation << "\nDistance: " << distance << " miles\n";
    }

    virtual ~Ride() {} // virtual destructor
};

// --------- Standard Ride Subclass ---------
class StandardRide : public Ride {
public:
    StandardRide(int id, string pickup, string dropoff, double dist)
        : Ride(id, pickup, dropoff, dist) {}

    double fare() const override {
        return distance * 1.5; // $1.5 per mile
    }

    void rideDetails() const override {
        cout << "[Standard Ride]\n";
        Ride::rideDetails();
        cout << "Fare: $" << fare() << endl;
    }
};

// --------- Premium Ride Subclass ---------
class PremiumRide : public Ride {
public:
    PremiumRide(int id, string pickup, string dropoff, double dist)
        : Ride(id, pickup, dropoff, dist) {}

    double fare() const override {
        return distance * 3.0; // $3.0 per mile
    }

    void rideDetails() const override {
        cout << "[Premium Ride]\n";
        Ride::rideDetails();
        cout << "Fare: $" << fare() << endl;
    }
};

// --------- Driver Class ---------
class Driver {
private:
    int driverID;
    string name;
    double rating;
    vector<shared_ptr<Ride>> assignedRides; // encapsulated

public:
    Driver(int id, string name, double rating)
        : driverID(id), name(name), rating(rating) {}

    void addRide(shared_ptr<Ride> ride) {
        assignedRides.push_back(ride);
    }

    void getDriverInfo() const {
        cout << "Driver ID: " << driverID << ", Name: " << name
             << ", Rating: " << rating << endl;
        cout << "Completed Rides: " << assignedRides.size() << endl;
    }
};

// --------- Rider Class ---------
class Rider {
private:
    int riderID;
    string name;
    vector<shared_ptr<Ride>> requestedRides; // encapsulated

public:
    Rider(int id, string name) : riderID(id), name(name) {}

    void requestRide(shared_ptr<Ride> ride) {
        requestedRides.push_back(ride);
    }

    void viewRides() const {
        cout << "Rider ID: " << riderID << ", Name: " << name << endl;
        for (const auto& ride : requestedRides) {
            ride->rideDetails();
            cout << "------------------------\n";
        }
    }
};

// --------- Main Function to Demonstrate the System ---------
int main() {
    // Create Rides
    shared_ptr<Ride> ride1 = make_shared<StandardRide>(101, "A", "B", 10.5);
    shared_ptr<Ride> ride2 = make_shared<PremiumRide>(102, "C", "D", 5.2);

    // Demonstrate polymorphism with a list of base class pointers
    vector<shared_ptr<Ride>> rides = {ride1, ride2};

    for (const auto& ride : rides) {
        ride->rideDetails();
        cout << "========================\n";
    }

    // Create Driver and assign rides
    Driver driver1(1, "Alice", 4.8);
    driver1.addRide(ride1);
    driver1.addRide(ride2);
    driver1.getDriverInfo();

    cout << "------------------------\n";

    // Create Rider and request rides
    Rider rider1(1001, "Bob");
    rider1.requestRide(ride1);
    rider1.requestRide(ride2);
    rider1.viewRides();

    return 0;
}
