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
struct UnitConverter{
    var physicalUnits:[String] = ["Temperature","Distance"]
    var physicalUnitMeasures:[String:[String]] = ["Temperature":["Celsius","Farenheit","Kelvin"],
                                                  "Distance":["Meters","Kilometers","Miles"]]
    
    func selectPhysicalUnit(index:Int)->String{
        
        return physicalUnits[index]
    }
    
    func selectUnitToConvert(index:Int,measure:Int)->String{
        
        return physicalUnitMeasures[physicalUnits[index]]?[measure] ?? "Temperature"
    }
    
    func convert(units:Double,convertFrom:String,convertTo:String)->Double{
            //Temperature
            if convertFrom == "Celsius" && convertTo == "Farenheit" {

                 return units * 9/5 + 32
            }
            else if convertFrom == "Celsius" && convertTo == "Kelvin"{

                return units + 273.15
            }
            else if convertFrom == "Farenheit" && convertTo == "Celsius"{

                return (units - 32) * 5/9
            }
            else if convertFrom == "Farenheit" && convertTo == "Kelvin"{

                return (units + 459.67) * 5/9
            }
            else if convertFrom == "Kelvin" && convertTo == "Celcius"{

                return units - 273.15
            }
            else if convertFrom == "Kelvin" && convertTo == "Farenheit"{

                return (units - 273.15) * 9/5 + 32

            }
            //Distance
            else if convertFrom == "Meters" && convertTo == "Kilometers"{

                return units/1000
            }

            else if convertFrom == "Meters" && convertTo == "Miles"{

                return units / 1609
            }
            else if convertFrom == "Kilometers" && convertTo == "Meters"{

                return units * 1000
            }

            else if convertFrom == "Kilometers" && convertTo == "Miles"{

                return units / 1.609
            }
            else if convertFrom == "Miles" && convertTo == "Meters"{

                return units * 1609
            }
            else if convertFrom == "Miles" && convertTo == "Kilometers"{

                return units * 1.609

            }

            return units
        }
}
struct ContentView: View {
    @State var convertedUnits:Double = 0.0
    
    @State private var unitValue = 300.0
    @State private var physicalUnits:[String] = []
    @State private var physicalUnitMeasures:[String: [String]] = [:]
    @State private var selectedUnit:String=""
    @State private var selectedMeasureToConvertFrom:String=""
    @State private var selectedMeasureToConvertTo:String=""
    var converter:UnitConverter
    init(converter:UnitConverter){
       //converter = UnitConverter()
        self.converter = converter
        
    }
    
    func populateContentView(){
        physicalUnits = converter.physicalUnits
        physicalUnitMeasures = converter.physicalUnitMeasures
        selectedUnit = converter.selectPhysicalUnit(index: 0)
        selectedMeasureToConvertFrom = converter.selectUnitToConvert(index: 0, measure: 0)
        selectedMeasureToConvertTo = converter.selectUnitToConvert(index: 0, measure: 1)
        convertedUnits = converter.convert(units: unitValue, convertFrom: selectedMeasureToConvertFrom, convertTo: selectedMeasureToConvertTo)
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
        .onAppear{populateContentView()}
        }
        
        
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(converter: UnitConverter())
    }
}
