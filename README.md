# MSCS632_Assignment-5
# Ride Sharing System in C++ & Pharo Smalltalk

## Overview
This project implements a ride-sharing system demonstrating key OOP principles:
- Encapsulation
- Inheritance  
- Polymorphism

## System Components

### Classes
1. **Ride** (Base Class)
   - Core ride details: ID, locations, distance, fare
   - Basic fare calculation ($1/mile)
   - Ride details display

2. **StandardRide** (Subclass)
   - Standard fare calculation ($1.5/mile)

3. **PremiumRide** (Subclass)  
   - Premium fare calculation ($2.5/mile + $5 base)

4. **Driver**
   - Driver attributes: ID, name, rating
   - Ride management
   - Driver information display

5. **Rider**
   - Rider attributes: ID, name  
   - Ride request history
   - Ride viewing functionality

## OOP Principles Demonstrated

### Encapsulation
- Private instance variables accessed via methods
- Hidden implementation details (e.g., fare calculation)

### Inheritance  
- StandardRide and PremiumRide inherit from Ride
- Shared attributes/methods in parent class

### Polymorphism
- Different ride types respond to same messages
- Collections handle different ride types uniformly
