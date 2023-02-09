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

class PhysicalUnits:ObservableObject{
    @Published var unitValue:Double = 0
    @Published var selectedUnit:String = "Temperature"
    @Published var selectedMeasureToConvertFrom:String = "Celcius"
    @Published var selectedMeasureToConvertTo:String = "Kelvin"
    var conversionResult:Double{
        get{
           
           converter(unitValue: unitValue, convertFrom: selectedMeasureToConvertFrom, ConvertTo: selectedMeasureToConvertTo)
        }

    }

    enum Units:String,CaseIterable{
        case temperature = "Temperature"
        case distance = "Distance"
       
        struct Temperature{
            enum UnitMeasures:String,CaseIterable{
                case celcius = "Celcius"
                case farenheit = "Farenheit"
                case kelvin = "Kelvin"
            }
            
            struct Celcius{
                var temperature:Double
                
                init(fromFarenheit unitValue:Double){
                    temperature = (unitValue - 32)/1.8
                }
                
                init(fromKelvin unitValue:Double){
                    temperature = unitValue - 273.15
                }
            }
            
            struct Farenheit{
                var temperature:Double
                
                init(fromCelcius unitValue:Double){
                    temperature = unitValue * 9/5 + 32
                }
                
                init(fromKelvin unitValue:Double){
                    temperature = (unitValue - 273.15)*9/5 + 32
                }
            }
            
            struct Kelvin{
                var temperature:Double
                
                init(fromCelcius unitValue:Double){
                    temperature = unitValue + 273.15
                }
                
                init(fromFarenheit unitValue:Double){
                    temperature = (unitValue + 459.67)*5/9
                }
                
            }
        }
        
        struct Distance{
            enum UnitMeasures:String,CaseIterable{
                case meters = "Meters"
                case kilometers = "Kilometers"
                case miles = "Miles"
            }
            
            struct Meters{
                var distance:Double
                
                init(fromKilometers unitValue:Double){
                    distance = unitValue*1000
                }
                
                init(fromMiles unitValue:Double){
                    distance = unitValue*1609
                }
            }
            
            struct Kilometers{
                var distance:Double
                
                init(fromMeters unitValue:Double){
                    distance = unitValue/1000
                }
                
                init(fromMiles unitValue:Double){
                    distance = unitValue*1.609
                }
            }
            
            struct Miles{
                var distance:Double
                
                init(fromMeters unitValue:Double){
                    distance = unitValue/1609
                }
                
                init(fromKilometers unitValue:Double){
                    distance = unitValue/1.609
                }
            }
        }
    }

        func converter(unitValue:Double,convertFrom:String,ConvertTo:String)->Double{
        //Temperature
            if selectedMeasureToConvertFrom == "Celsius" && selectedMeasureToConvertTo == "Farenheit" {
                
                let result = PhysicalUnits.Units.Temperature.Farenheit(fromCelcius: unitValue)
                
               return result.temperature
            }
            else if  selectedMeasureToConvertFrom == "Celsius" && selectedMeasureToConvertTo == "Kelvin"{
                
                let result = PhysicalUnits.Units.Temperature.Kelvin(fromCelcius: unitValue)
               return  result.temperature
            }
            else if selectedMeasureToConvertFrom == "Farenheit" && selectedMeasureToConvertTo == "Celsius"{
                
                let result = PhysicalUnits.Units.Temperature.Celcius(fromFarenheit: unitValue)
                
                return result.temperature
            }
            else if selectedMeasureToConvertFrom == "Farenheit" && selectedMeasureToConvertTo == "Kelvin"{
                
                let result = PhysicalUnits.Units.Temperature.Kelvin(fromFarenheit: unitValue)
                return result.temperature
            }
            else if selectedMeasureToConvertFrom == "Kelvin" && selectedMeasureToConvertTo == "Celcius"{
                
                let result = PhysicalUnits.Units.Temperature.Celcius(fromKelvin: unitValue)
                
                return result.temperature
            }
            else if selectedMeasureToConvertFrom == "Kelvin" && selectedMeasureToConvertTo == "Farenheit"{
                
                let result = PhysicalUnits.Units.Temperature.Farenheit(fromKelvin: unitValue)
                
                return result.temperature
                
            }
            //Distance
            else if selectedMeasureToConvertFrom == "Meters" && selectedMeasureToConvertTo == "Kilometers"{

                let result = PhysicalUnits.Units.Distance.Kilometers(fromMeters: unitValue)
                
                return result.distance
                
            }
            
            else if selectedMeasureToConvertFrom == "Meters" && selectedMeasureToConvertTo == "Miles"{

                let result = PhysicalUnits.Units.Distance.Miles(fromMeters: unitValue)
                
                return result.distance
            }
            else if selectedMeasureToConvertFrom == "Kilometers" && selectedMeasureToConvertTo == "Meters"{

                let result = PhysicalUnits.Units.Distance.Meters(fromKilometers: unitValue)
                
                return result.distance
            }
           
            else if selectedMeasureToConvertFrom == "Kilometers" && selectedMeasureToConvertTo == "Miles"{
                
                let result = PhysicalUnits.Units.Distance.Miles(fromKilometers: unitValue)
                
                return result.distance
                 
            }
            else if selectedMeasureToConvertFrom == "Miles" && selectedMeasureToConvertTo == "Meters"{

                let result = PhysicalUnits.Units.Distance.Meters(fromMiles: unitValue)
                
                return result.distance
            }
            else if selectedMeasureToConvertFrom == "Miles" && selectedMeasureToConvertTo == "Kilometers"{
                
                let result = PhysicalUnits.Units.Distance.Kilometers(fromMiles: unitValue)
                
                return result.distance

            }
        else{
            return unitValue
        }
        
    }
}


struct ContentView: View {
    @ObservedObject var physicalUnits = PhysicalUnits()
    var body: some View {
        NavigationView{
            Form{
                Section{
                    Picker("Conversion", selection: $physicalUnits.selectedUnit){
                        ForEach(PhysicalUnits.Units.allCases,id: \.rawValue){ unit in
                            Text(unit.rawValue)
                        }
                    }
                    
                }header:{
                    Text("Please select the physical unit")
                }
                
                Section{
                    TextField("Unit Value",value:$physicalUnits.unitValue , format:.number)

                    switch physicalUnits.selectedUnit{
                    case "Temperature":
                        Picker("Convert from", selection: $physicalUnits.selectedMeasureToConvertFrom){
                            ForEach(PhysicalUnits.Units.Temperature.UnitMeasures.allCases,id: \.rawValue){ unit in
                                Text(unit.rawValue)
                            }
                        }
                    case "Distance":
                        Picker("Convert from", selection: $physicalUnits.selectedMeasureToConvertFrom){
                            ForEach(PhysicalUnits.Units.Distance.UnitMeasures.allCases,id: \.rawValue){ unit in
                                Text(unit.rawValue)
                            }
                        }
                    default:
                        Picker("Convert from", selection: $physicalUnits.selectedMeasureToConvertFrom){
                            ForEach(PhysicalUnits.Units.Temperature.UnitMeasures.allCases,id: \.rawValue){ unit in
                                Text(unit.rawValue)
                            }
                        }
                    }

                }header:{
                    Text("Enter the measure to be converted")
                }

                Section{
                    switch physicalUnits.selectedUnit{
                    case "Temperature":
                        Picker("Convert to", selection: $physicalUnits.selectedMeasureToConvertTo){
                            ForEach(PhysicalUnits.Units.Temperature.UnitMeasures.allCases,id: \.rawValue){ unit in
                                Text(unit.rawValue)
                            }
                        }
                    case "Distance":
                        Picker("Convert to", selection: $physicalUnits.selectedMeasureToConvertTo){
                            ForEach(PhysicalUnits.Units.Distance.UnitMeasures.allCases,id: \.rawValue){ unit in
                                Text(unit.rawValue)
                            }
                        }
                    default:
                        Picker("Convert to", selection: $physicalUnits.selectedMeasureToConvertTo){
                            ForEach(PhysicalUnits.Units.Temperature.UnitMeasures.allCases,id: \.rawValue){ unit in
                                Text(unit.rawValue)
                            }
                        }
                    }

                }
                
                Section{
                    Text(physicalUnits.conversionResult,format:.number)
                }header:{
                    Text("Answer")
                }
                .navigationTitle("Unit Converter")
                
            }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
