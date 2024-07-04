//
//  ContentView.swift
//  SuperHeroApp
//
//  Created by Brayyan Christopher Trujillo Valle on 2/07/24.
//

import SwiftUI
import SDWebImageSwiftUI



struct ContentView: View {
    @State var superheroName = ""
    @State var wrapper:ApiNetwork.Wrapper? = nil
    @State var loading:Bool = false
    var body: some View {
        VStack {
            TextField("vxcfgvgf", text: $superheroName ,prompt:
                        Text("Superman...").font(.title2).bold().foregroundColor(.gray))
            .font(.title2)
            .bold()
            .foregroundColor(.white)
            .padding(16)
            .border(.purple , width: 2)
            .padding(8)
            .autocorrectionDisabled()
            .onSubmit {
                loading = true
                print(superheroName)
                Task {
                    do{
                        wrapper = try await ApiNetwork().getHeroesByQhuery(query:
                                                superheroName)
                       
                        
                    }catch{
                        print("Error")
                        
                    }
                    loading = false
                }
               
            }
            if loading{
                ProgressView().tint(.white)
            }
            NavigationStack{
                List(wrapper?.results ?? []){ superhero in
                    ZStack{
                    SuperheroItem(superhero: superhero)
                        NavigationLink(destination: {SuperheroDetail(id: "2")}){EmptyView()}.opacity(0)
                            
                    }.listRowBackground(Color.backgroundApp)
                }.listStyle(.plain)
                .background(.backgroundApp)
            }
            Spacer()
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: .infinity).background(.backgroundApp)
    }
}
struct SuperheroItem:View {
    let superhero:ApiNetwork.SuperHero
    var body: some View {
        ZStack{
       
            WebImage(url: URL(string: superhero.image.url))
                .resizable()
                .indicator(.activity)
                .scaledToFill()
                .frame(height: 200)
            VStack{
                Spacer()
                Text(superhero.name).foregroundStyle(.white)
                    .font(.title)
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.white.opacity(0.5))
            }
        }.frame(height: 200).cornerRadius(32)
        
    }
}

#Preview {
    ContentView()
}
