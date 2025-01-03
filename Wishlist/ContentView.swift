//
//  ContentView.swift
//  Wishlist
//
//  Created by k21047kk on 2025/01/03.
//

import SwiftUI
import SwiftData

struct ContentView: View {
  
  @Environment(\.modelContext) private var modelContext
  @Query private var wishes: [Wish]
  
  @State private var isAlertShowing: Bool = false
  
  @State private var title: String = ""
  
  var body: some View {
    NavigationStack {
      List {
        ForEach(wishes) { wish in
          Text(wish.title)
            .font(.title.weight(.light))
            .padding(.vertical,2)
            .swipeActions {
              Button("Delete",role: .destructive) {
                modelContext.delete(wish)
              }
            }
        }
        
      } //:List
      .navigationTitle("Wishlist")
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          Button {
            isAlertShowing.toggle()
          } label: {
            Image(systemName: "plus")
              .imageScale(.large)
          }
        }
        
        if wishes.isEmpty != true {
          ToolbarItem(placement: .bottomBar) {
            Text("\(wishes.count) wish\(wishes.count > 1 ? "es" : "")")
              .font(.caption)
          }
        }
      }
      .alert("create a new wish",isPresented: $isAlertShowing) {
        TextField("Enter your wish",text: $title)
        
        Button {
          let wish = Wish(title: title)
          modelContext.insert(wish)
          title = ""
        } label: {
          Text("Save")
        }
        
      }
      .overlay {
        if wishes.isEmpty {
          ContentUnavailableView(
            "My Wishlist",
            systemImage: "heart.circle",
            description: Text("No wishes yet. Add one to ge started.")
          )
        }
      }
    }
    
  }
}

#Preview("List With Sample Data") {
  
  let container = try! ModelContainer(
    for: Wish.self,
    configurations: ModelConfiguration(isStoredInMemoryOnly: true)
  )
  
  container.mainContext.insert(Wish(title: "Master SwiftData"))
  container.mainContext.insert(Wish(title: "Buy a new iPhone"))
  container.mainContext.insert(Wish(title: "Learn SwiftUI"))
  container.mainContext.insert(Wish(title: "Travel to Japan"))
  container.mainContext.insert(Wish(title: "Get a new job"))
  
 return ContentView()
    .modelContainer(container)
}

#Preview("Empty List") {
    ContentView()
    .modelContainer(for: Wish.self,inMemory: true)
}
