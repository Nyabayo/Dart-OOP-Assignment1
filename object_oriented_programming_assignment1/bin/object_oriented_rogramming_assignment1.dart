// Import the dart:io library to use file operations for reading data from a file.
// This library provides access to file, directory, and path operations.
import 'dart:io';

/* Abstract Class Animal */
// This is the base class for our model. It's declared as abstract, meaning it cannot be instantiated directly.
// Abstract classes are typically used to provide a common definition of a base class that multiple derived classes can share.
abstract class Animal {
  // Properties of the class. In OOP, properties are attributes that hold data relevant to an object.
  // Here, 'name' and 'age' are properties common to all animals.
  String name;
  int age;

  // Constructor: A special function that is called when an object is instantiated from a class.
  // This constructor initializes the object's properties. The syntax 'this.name' and 'this.age' initializes the class's properties with the values passed to the constructor.
  Animal(this.name, this.age);

  // A method defined in the abstract class. Methods are functions defined within a class that operate on the data contained by an object.
  // This method can be overridden by subclasses to provide specific behavior but also provides default behavior if not overridden.
  void describe() {
    print("I am $name and I am $age years old.");
  }
}

/* Interface FeedingBehavior */
// Defines an interface. In Dart, interfaces are defined using abstract classes.
// An interface is a contract that specifies a set of methods a class must implement.
// Classes that implement this interface must provide concrete implementations of all its methods.
abstract class FeedingBehavior {
  void feed();
}

/* Class Dog Extends Animal and Implements FeedingBehavior */
// The 'Dog' class demonstrates inheritance by extending 'Animal', and it demonstrates polymorphism by implementing the 'FeedingBehavior' interface.
class Dog extends Animal implements FeedingBehavior {
  // A new property specific to the Dog class. This demonstrates how subclasses can have their own unique properties in addition to those inherited from the base class.
  String breed;

  // Constructor for Dog. It calls the constructor of the base class (Animal) to initialize inherited properties.
  // The ': super(name, age)' syntax is used to call the base class constructor.
  Dog(String name, int age, this.breed) : super(name, age);

  // Overriding a method: This is a key OOP concept where a subclass provides its own implementation of a method defined in its superclass.
  // The '@override' annotation indicates that the method overrides a superclass method.
  // This allows 'Dog' to include additional behavior (printing the breed) when the 'describe' method is called.
  @override
  void describe() {
    super.describe(); // Calls the describe method in the superclass (Animal).
    print("Breed: $breed");
  }

  // Implementing the 'feed' method from the FeedingBehavior interface.
  // This is required because Dog implements FeedingBehavior, and Dart requires all methods of an interface to be implemented.
  @override
  void feed() {
    print("$name is now eating.");
  }

  // Demonstrating the use of a loop within a class method.
  // Loops are control structures that repeat a block of code multiple times. Here, it's used to simulate the dog barking 'n' times.
  void barkNTimes(int n) {
    for (int i = 0; i < n; i++) {
      print("Bark!");
    }
  }
}

/* Function to Create Dog Instance from File */
// This function asynchronously reads data from a file and initializes a Dog object with that data.
// It demonstrates file I/O operations, asynchronous programming with futures and async/await, and object initialization with data.
Future<Dog> createDogFromFile(String filePath) async {
  final file = File(
      filePath); // The 'File' class is used to reference the file located at 'filePath'.
  final lines = await file
      .readAsLines(); // Asynchronously reads all lines from the file. This operation returns a Future that completes with a list of strings.

  // Assumes the file's content is formatted as "name,age,breed".
  // The 'split' method is used to divide the string into parts based on commas.
  var parts = lines[0].split(',');
  // The parts are then used to instantiate and return a new Dog object.
  return Dog(parts[0], int.parse(parts[1]), parts[2]);
}

// Example Usage: The entry point of the Dart application.
// This async function demonstrates creating a Dog instance from file data and invoking its methods.
void main() async {
  // Assuming there's a file named 'dog_data.txt' with content in the format "Rex,5,Labrador".
  var dog = await createDogFromFile(
      'dog_data.txt'); // Asynchronously creates a Dog object from file data.
  dog.describe(); // Calls the overridden describe method, which includes breed information.
  dog.feed(); // Demonstrates interface implementation by calling the feed method.
  dog.barkNTimes(3); // Demonstrates using a loop within a method.
}
