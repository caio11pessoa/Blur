//
//  DanishinChallenge.swift
//  BlurBackground
//
//  Created by Caio de Almeida Pessoa on 11/03/25.
//

import SwiftUI

struct DanishinChallenge: View {
    @State var blurPercentage: CGFloat = 0.45
    var blurPercentageFinished: CGFloat {
        if blurPercentage <= 0.9 {
            return blurPercentage + 0.1
        }
        return 1
        
    }
    
    var gradient: LinearGradient{ LinearGradient(
        gradient: Gradient(stops: [
            .init(color: .black, location: 0),
            .init(color: .black, location: blurPercentage),
            .init(color: .clear, location: blurPercentage + 0.1)
        ]),
        startPoint: .bottom,
        endPoint: .top
    )}
    
    func rowComponent(_ systemName: String, rowName: String, wave: Bool = false) -> some View {
        HStack{
            Image(systemName: systemName)
                .foregroundStyle(wave ? .white : Color(cgColor: .init(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)))
            
            Text(rowName)
                .foregroundStyle(wave ? .white : Color(cgColor: .init(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)))
            Spacer()
            Image(systemName: "heart.fill")
                .foregroundStyle(.gray)
                .font(.system(size: 10))
            Group{
                
                ZStack{
                    Image(systemName: "circle.fill")
                    Image(systemName: "sparkles")
                        .font(.system(size: 16))
                        .blendMode(.destinationOut)
                }
                .compositingGroup()

                wave ? Image(systemName: "speaker.wave.2.circle.fill") : Image(systemName: "speaker.slash.circle.fill")
            }
            .font(.system(size: 32))
            
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image(.wallPaper)
                    .resizable()
                Image(.wallPaper)
                    .resizable()
                    .blur(radius: 25)
                    .padding(-35)
                    .clipped()
                    .mask(gradient)
                //                                gradient
                //                                    .opacity(0.25)
                VStack(spacing: 0){
                    Spacer()
                    List {
                        Section {
                            Group{
                                rowComponent("bird.fill", rowName: "Birds Singing", wave: true)
                                rowComponent("fireplace.fill", rowName: "Fireplace", wave: false)
                                rowComponent("leaf.fill", rowName: "Leaves", wave: false)
                            }
                            .listRowBackground(Color.clear)
                            .foregroundStyle(.white)
                            .listRowSeparatorTint(Color.divider, edges: .all)
                        } header: {
                            Text("Favorites")
                                .foregroundStyle(.divider)
                                .bold()
                        }
                        
                        Divider()
                            .listRowBackground(Color.clear)
                            .background(.divider)
                            .padding(.horizontal, -20)
                        
                        Section{
                            Group{
                                rowComponent("bird.fill", rowName: "Night", wave: false)
                                rowComponent("fireplace.fill", rowName: "Rain", wave: false)
                                rowComponent("leaf.fill", rowName: "Lightning", wave: false)
                                    .listRowSeparator(.visible)
                            }
                            .listRowBackground(Color.clear)
                            .foregroundStyle(.white)
                            
                        }
                        header: {
                            Text("Favorites")
                                .foregroundStyle(.divider)
                                .bold()
                        }
                    }
                    .padding(.horizontal, -20)
                    .scrollContentBackground(.hidden)
                    .frame( height: UIScreen.main.bounds.height * blurPercentage)
                }
            }
            .ignoresSafeArea()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Sounds")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundStyle(.divider)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    HStack{
                        ZStack{
                            Image(systemName: "circle.fill")
                                .foregroundStyle(.divider)
                                .font(.system(size: 32))
                            Image(systemName: "timer")
                                .font(.system(size: 18))
                                .blendMode(.destinationOut)
                        }
                        .compositingGroup()
                        ZStack {
                            Image(systemName: "circle.fill")
                                .foregroundStyle(.divider)
                                .font(.system(size: 32))

                            Image(systemName: "waveform")
                                .font(.system(size: 16))
                                .blendMode(.destinationOut)
                        }
                        .compositingGroup()
                        ZStack {
                            Image(systemName: "circle.fill")
                                .foregroundStyle(.divider)
                                .font(.system(size: 32))
                            Image(systemName: "gearshape.fill")
                                .font(.system(size: 16))
                                .blendMode(.destinationOut)
                        }
                        .compositingGroup()
                    }
                }
            }
        }
    }
    
}

#Preview {
    DanishinChallenge()
}
