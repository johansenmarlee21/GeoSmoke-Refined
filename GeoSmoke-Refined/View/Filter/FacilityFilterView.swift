//
//  FacilityFilterView.swift
//  GeoSmoke-Refined
//
//  Created by Johansen Marlee on 16/04/25.
//

import SwiftUI
import SwiftData

struct FacilityFilterView: View {
    @State private var viewModel = FacilityFilterViewModel()
    
    var onSelect: ((SmokingArea)->Void)? = nil
    
    var body: some View{
        ScrollView {
            LazyVStack() {
                ForEach(viewModel.sortedSmokingAreas, id: \.self) { area in
                    FacilityViewItem(area: area,
                                     isSelected: viewModel.selectedArea?.id == area.id,
                                     onSelect: { selected in
                        viewModel.selectedArea = selected
                        onSelect?(selected)
                    }
                    )
                    .padding(.bottom, 3)
                }
            }
            .padding(.top, 10)
        }
    }
}

struct FacilityViewItem: View {
    let area: SmokingArea
    var isSelected: Bool
    var onSelect: ((SmokingArea) -> Void)? = nil
    
    @State private var showDetail = false
    
    var body: some View {
        HStack(alignment: .center){
            if UIImage(named: area.photoURL) != nil {
                Image(area.photoURL)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 115, height: 70)
                    .cornerRadius(5)
                    .padding(.leading, 5)
            } else {
                Text("Image not found: \(area.photoURL)")
                    .foregroundColor(.red)
            }
            
            
            VStack(alignment: .leading, spacing: 0) {
                Text(area.name)
                    .font(.headline)
                HStack{
                    Text(area.location)
                        .font(.system(size: 13))
                        .padding(.vertical, 1)
                        .padding(.horizontal, 8)
                        .background(Color.green300)
                        .cornerRadius(8)
                        .padding(.top, 2)
                    
                    Text(area.facilityGrade)
                        .font(.system(size: 13))
                        .fontWeight(.semibold)
                        .padding(.vertical, 1)
                        .padding(.horizontal, 8)
                        .background(colorForFacilityGrade(area.facilityGrade))
                        .cornerRadius(4)
                        .padding(.top, 2)
                    
                    
                }
                
                Spacer()
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        ForEach(area.facilities, id: \.name) { facility in
                            Image(systemName: iconName(for: facility.name))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15, height: 15)
                                .padding(.trailing, 3)
//                                .background(Color.green.opacity(0.3))
//                                .clipShape(Circle())
                        }
                    }
                }
                
            }
            
            Spacer()
            
            VStack{
                Button(action: {
                    showDetail = true
                }){
                    VStack(alignment: .center){
                        Image(systemName: "location.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color.white)
                        
                        Text("Detail")
                            .font(.subheadline)
                            .foregroundColor(Color.white)
                    }
                    .frame(width: 60)
                    .frame(maxHeight: 70)
                    .background(Color.orangetheme)
                    .cornerRadius(10)
                    .padding(.trailing, 5)
                }
                .fullScreenCover(isPresented: $showDetail) {
                    DetailView(area: area)
                }
            }
            
        }
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .frame(height: 85)
        .background(Color.green100)
        .cornerRadius(10)
        .onTapGesture {
            onSelect?(area)
        }
        .shadow(color: .splashGreen.opacity(isSelected ? 0.7 : 0),
                radius: isSelected ? 5 : 0)
    }
    
    func colorForFacilityGrade(_ grade: String) -> Color {
        switch grade {
        case "High":
            return .green
        case "Moderate":
            return .yellow
        case "Low":
            return .red
        default:
            return .gray
        }
    }
    
    func iconName(for facility: String) -> String {
        switch facility {
        case "Chair":
            return "chair.lounge"
        case "Waste Bin":
            return "trash"
        case "Roof":
            return "house"
        default:
            return "questionmark.circle" // fallback icon
        }
    }
    
}
