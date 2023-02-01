//
//  ContentView.swift
//  UnitConverter
//
//  Created by Anthony Mugasa Jr on 31/01/2023.
//
/*
The Challenge
You need to build an app that handles unit conversions: users will select an input unit and an output unit, then enter a value, and see the output of the conversion.

Which units you choose are down to you, but you could choose one of these:

Temperature conversion: users choose Celsius, Fahrenheit, or Kelvin.
Length conversion: users choose meters, kilometers, feet, yards, or miles.
Time conversion: users choose seconds, minutes, hours, or days.
Volume conversion: users choose milliliters, liters, cups, pints, or gallons.
If you were going for length conversion you might have:

A segmented control for meters, kilometers, feet, yard, or miles, for the input unit.
A second segmented control for meters, kilometers, feet, yard, or miles, for the output unit.
A text field where users enter a number.
A text view showing the result of the conversion.
*/
import SwiftUI

struct ContentView: View {
    @State private var unitValue = 0.0
    @State private var physicalUnits = ["Temperature","Distance","Time","Volume"]
    @State private var selectedUnit = "Temperature"
    
    
    @State private var physicalUnitMeasures:[String: [String]] = [
        "Temperature":["Celsius","Farenheit","Kelvin"],
        "Distance":["Meters","Kilometers","Miles"]
    ]
    
    @State private var selectedMeasureToConvertFrom = "Celsius"
    @State private var selectedMeasureToConvertTo = "Farenheit"
    
    var convertedUnits:Double{
        //Temperature
        if selectedMeasureToConvertFrom == "Celsius" && selectedMeasureToConvertTo == "Farenheit" {
            
             return unitValue * 9/5 + 32
        }
        else if  selectedMeasureToConvertFrom == "Celsius" && selectedMeasureToConvertTo == "Kelvin"{
            
            return unitValue + 273.15
        }
        else if selectedMeasureToConvertFrom == "Farenheit" && selectedMeasureToConvertTo == "Celsius"{
            
            return (unitValue - 32) * 5/9
        }
        else if selectedMeasureToConvertFrom == "Farenheit" && selectedMeasureToConvertTo == "Kelvin"{
            
            return (unitValue + 459.67) * 5/9
        }
        else if selectedMeasureToConvertFrom == "Kelvin" && selectedMeasureToConvertTo == "Celcius"{
            
            return unitValue - 273.15
        }
        else if selectedMeasureToConvertFrom == "Kelvin" && selectedMeasureToConvertTo == "Farenheit"{
            
            return (unitValue - 273.15) * 9/5 + 32
            
        }
        //Distance
        else if selectedMeasureToConvertFrom == "Meters" && selectedMeasureToConvertTo == "Kilometers"{

            return unitValue/1000
        }
        
        else if selectedMeasureToConvertFrom == "Meters" && selectedMeasureToConvertTo == "Miles"{

            return unitValue / 1609
        }
        else if selectedMeasureToConvertFrom == "Kilometers" && selectedMeasureToConvertTo == "Meters"{

            return unitValue * 1000
        }
       
        else if selectedMeasureToConvertFrom == "Kilometers" && selectedMeasureToConvertTo == "Miles"{

            return unitValue / 1.609
        }
        else if selectedMeasureToConvertFrom == "Miles" && selectedMeasureToConvertTo == "Meters"{

            return unitValue * 1609
        }
        else if selectedMeasureToConvertFrom == "Miles" && selectedMeasureToConvertTo == "Kilometers"{
            
            return unitValue * 1.609

        }

        return 0
    }
    var body: some View {
        NavigationView{
            Form{
                Section{
                    Picker("Conversion", selection: $selectedUnit){
                        ForEach(physicalUnits,id: \.self){
                            Text("\($0)")
                        }
                    }
                }header:{
                    Text("Please select the physical unit")
                }
                
                Section{
                    TextField("Unit Value",value:$unitValue , format:.number)
                    Picker("Convert from", selection: $selectedMeasureToConvertFrom){
                        
                        ForEach(physicalUnitMeasures[selectedUnit] ?? ["N/A"],id:\.self){
                            Text("\($0)")
                        }
                    }
                        
                }header:{
                    Text("Enter the measure to be converted")
                }
                
                Section{
                    Picker("Convert to", selection: $selectedMeasureToConvertTo){
                        ForEach(physicalUnitMeasures[selectedUnit] ?? ["N/A"],id:\.self){
                            Text("\($0)")
                        }
                        
                        
                    }
                    
                        
                }
                Section{
                    Text(convertedUnits,format:.number)
                }header:{
                    Text("Answer")
                }
                

                }.navigationTitle("Unit Converter")
            }
        }
        
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
