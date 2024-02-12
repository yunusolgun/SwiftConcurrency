//
//  StructClassActorBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by yunus olgun on 6.01.2024.
//


/*
 
 
 VALUE TYPES:
 - Struct, Enum, String, Int, etc.
 - Stored in the Stack
 - Faster
 - Thread safe!
 - When you assing or pass value type a new copy of data is created
 
 REFERENCE TYPES:
 - Class, Function, Actor
 - Stored in the Heap
 - Slower but synchronized
 - NOT Thread safe
 - When you assing or pass reference type a new reference to original instance will be created (pointer)
 
 
 STACK:
 - Stored value types
 - Variables allocated on the stack are stored directly to the memory, and access to this memory is very fast
 - Each thread has it's own stack!
 
 
 HEAP:
 - Stores reference types
 - Shared across threads!
 
 
 
 STRUCT:
 - Based on VALUES
 - Can be mutated
 - Stored in the stack!
 
 CLASS:
 - Based on REFERENCES (instances)
 - Stored in the Heap!
 - Inherit from other classes
 
 ACTOR:
 - Same as class, but thread safe!
 
 
 - - - - - - - - - - -
 
 Stucts: Data Models, Views
 Classes: ViewModels
 Actors: Shared "Manager" and "Data Store"
 
 
 
 
 */

import SwiftUI

struct StructClassActorBootcamp: View {
    var body: some View {
        Text("Hello, World!")
            .onAppear(perform: {
                runTest()
            })
    }
}

struct MyStruct {
    var title: String
}



extension StructClassActorBootcamp {
    private func runTest() {
        print("Test started")
        structTest1()
        printDivider()
        classTest1()
        printDivider()
        actorTest1()
//        structTest2()
//        printDivider()
//        classTest2()
    }
    
    private func printDivider() {
        print("""
        
        - - - - - - - - - - - - - - - -
        
        """)
    }
    
    private func structTest1() {
        print("structTest1")
        let objectA = MyStruct(title: "Starting title!")
        print("ObjectA: ", objectA.title)
        
        print("Pass the VALUES of objectA to objectB")
        var objectB = objectA
        print("ObjectB: ", objectB.title)
        print("ObjectB title changed.")
        
        objectB.title = "Second title!"
        print("ObjectA: ", objectA.title)
        print("ObjectB: ", objectB.title)
        print("objectA: \(objectA)  -- objectB: \(objectB)")

        
    }
    
    private func classTest1() {
        print("classTest1")
        let objectA = MyClass(title: "Starting title!")
        print("ObjectA: ", objectA.title)
        
        print("Pass the REFERENCES of objectA to objectB")
        let objectB = objectA
        print("ObjectB: ", objectB.title)
        print("ObjectB title changed.")
        
        objectB.title = "Second title!"
        print("ObjectA: ", objectA.title)
        print("ObjectB: ", objectB.title)
        print("objectA: \(objectA)  -- objectB: \(objectB)")
    }
    
    
    private func actorTest1() {
        Task {
            print("actorTest1")
            let objectA = MyActor(title: "Starting title!")
            await print("ObjectA: ", objectA.title)
            
            print("Pass the REFERENCES of objectA to objectB")
            let objectB = objectA
            await print("ObjectB: ", objectB.title)
            print("ObjectB title changed.")
            
            await objectB.updateTitle(newTitle: "Second title!")
            await print("ObjectA: ", objectA.title)
            await print("ObjectB: ", objectB.title)
            print("objectA: \(objectA)  -- objectB: \(objectB)")
        }

    }
    
}

struct CustomStruct {
    let title: String
    
    func updateTitle(newTitle: String) -> CustomStruct {
        CustomStruct(title: newTitle)
    }
}


struct MutatingStruct {
    private(set) var title: String
    
    init(title: String) {
        self.title = title
    }
    
    mutating func updateTitle(newTitle: String) {
        title = newTitle
    }
    
}

extension StructClassActorBootcamp {
    private func structTest2() {
        print("structTest2")
        
        var struct1 = MyStruct(title: "Title1")
        print("Struct1: ", struct1.title)
        struct1.title = "Title2"
        print("Struct1: ", struct1.title)
        
        
        var struct2 = CustomStruct(title: "Title1")
        print("Struct2: ", struct2.title)
        struct2 = CustomStruct(title: "Title2")
        print("Struct2: ", struct2.title)
        
        var struct3 = CustomStruct(title: "Title1")
        print("Struct3: ", struct3.title)
        struct3 = struct3.updateTitle(newTitle: "Title2")
        print("Struct3: ", struct3.title)
        
        var struct4 = MutatingStruct(title: "Title1")
        print("Struct4: ", struct4.title)
        struct4.updateTitle(newTitle: "Title2")
        print("Struct4: ", struct4.title)
        
    }
}


class MyClass {
    var title: String
    
    init(title: String) {
        self.title = title
    }
    
    func updateTitle(newTitle: String) {
        title = newTitle
    }
    
}


actor MyActor {
    var title: String
    
    init(title: String) {
        self.title = title
    }
    
    func updateTitle(newTitle: String) {
        title = newTitle
    }
    
}

extension StructClassActorBootcamp {
    
    private func classTest2() {
        print ("classTest2")
        
        let class1 = MyClass(title: "Title1")
        print("Class1: ", class1.title)
        class1.title = "Title2"
        print("Class1: ", class1.title)
        
        let class2 = MyClass(title: "Title1")
        print("Class2: ", class2.title)
        class2.updateTitle(newTitle: "Title2")
        print("Class2: ", class2.title)
        
        
    }
    
}
