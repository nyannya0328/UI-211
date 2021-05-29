//
//  Home.swift
//  UI-211
//
//  Created by にゃんにゃん丸 on 2021/05/29.
//

import SwiftUI
import CoreLocation

struct Home: View {
    @StateObject var model = MapViewModel()
    
    @State var locactionManager = CLLocationManager()
    
    @State var showText = false
    var body: some View {
        ZStack{
            
             MapView()
                .environmentObject(model)
                .ignoresSafeArea(.all, edges: .all)
            
            
            
            
            
            VStack{
                
                VStack(spacing:0){
                    
                    if showText{
                        
                        
                        HStack{
                            
                          Image(systemName: "magnifyingglass.circle.fill")
                                .foregroundColor(.gray)
                            
                            
                            TextField("Search Location", text: $model.txt)
                            
                            
                            Button(action: {
                                
                                withAnimation(.spring()){
                                    
                                    showText = false
                                }
                                
                            }, label: {
                                Text("BACK")
                            })
                            
                            
                            
                            
                        }
                        .padding(.vertical,10)
                        .padding(.horizontal)
                        .background(Color.white)
                        .cornerRadius(15)
                        
                        
                        
                    }
                    
                    else{
                        
                        
                        Button(action: {
                            
                            withAnimation(.linear){
                                
                                
                                showText = true
                            }
                            
                        }, label: {
                            Image(systemName: "magnifyingglass.circle.fill")
                                  .foregroundColor(.gray)
                        })
                        
                    }
                    
                    
                    if !model.places.isEmpty && model.txt != ""{
                        
                        
                        ScrollView{
                            
                            
                            VStack{
                                
                                ForEach(model.places){place in
                                    
                                    
                                    Text(place.placeMark.name ?? "")
                                        .font(.system(size: 20, weight: .light))
                                        .foregroundColor(.primary)
                                        .frame(maxWidth: .infinity,alignment: .leading)
                                        .onTapGesture {
                                            
                                            
                                            model.selecetPlace(place: place)
                                        }
                                    
                                    
                                    Divider()
                                        .background(Color.gray)
                                    
                                    
                                }
                              
                                
                                
                               
                                
                                
                                
                            }
                            .padding(.top)
                            
                            
                            
                        }
                        .background(Color.white)
                        
                    }
                    
                }
                .padding()
                
                
                
             
                
                
                Spacer()
                
                
                
                
                
                VStack{
                    
                   
                    
                    Button(action: model.foucusRegion) {
                        
                        
                        Image(systemName: "location.fill.viewfinder")
                            .font(.system(size: 30, weight: .bold))
                            .padding(10)
                            .background(Color.primary)
                            .clipShape(Circle())
                            .shadow(color: .green, radius: 10, x: 0, y: 0)
                            
                            
                        
                        
                    }
                    
                    Button(action: model.changeType) {
                        
                        
                        Image(systemName:model.mapType == .standard ? "network" : "map.fill")
                            .font(.system(size: 30, weight: .bold))
                            .padding(10)
                            .background(Color.primary)
                            .clipShape(Circle())
                            .shadow(color: .blue, radius: 10, x: 0, y: 0)
                            
                            
                        
                        
                    }
                    
                    
                    
                    
                    
                    
                }
                .frame(maxWidth: .infinity,alignment: .trailing)
                
                
            }
           
            
            
            
            
            
            
            
        }
        .onAppear(perform: {
            locactionManager.delegate = model
            locactionManager.requestWhenInUseAuthorization()
        })
        .alert(isPresented: $model.permissionDeneid, content: {
            Alert(title: Text("Permisson Denied"), message: Text("Pleace Enable Permisson In AppSettings"), dismissButton: .destructive(Text("Go to Settings"), action: {
                
               
                
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                
                
                
            }))
        })
        .onChange(of: model.txt, perform: { value in
            let delay = 0.2
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                
                if value == model.txt{
                    
                    model.searchQuery()
                    
                }
                
            }
        })
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
