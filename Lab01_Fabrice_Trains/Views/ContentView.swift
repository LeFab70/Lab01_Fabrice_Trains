//
//  ContentView.swift
//  Lab01_Fabrice_Trains
//
//  Created by Fabrice Kouonang on 2025-07-14.
//

import SwiftUI

struct ContentView: View {
    @State private var isSimpleMode: Bool = true {
        didSet {
            simpleModel.predictedPrice = nil
            multiModel.predictedPrice = nil
        }
    }
    @State private var simpleModel = TaxiFareSimpleModels()
    @State private var multiModel = TaxiFareMultiMultiModels()
    var isPredictEnabled: Bool {
        if isSimpleMode {
            return simpleModel.fare > 0
        } else {
            return multiModel.fare > 0 && multiModel.miscellaneousFees > 0 && multiModel.tip > 0
        }
    }
    var body: some View {
            VStack (spacing: 10) {
                VStack (spacing:15) {
                    Text("Estimate total fare for a train journey")
                        .font(.title.bold())
                        .fontWeight(.bold)
                    HStack(spacing:30) {
                      Image(systemName: "car.circle")
                          .font(.system(size: 50, weight: .bold))
                          .foregroundStyle(.red)
                      Image(systemName: "singaporedollarsign.arrow.trianglehead.counterclockwise.rotate.90")
                          .font(.system(size: 50, weight: .bold))
                          .foregroundStyle(.red)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green.opacity(0.3))
                .foregroundStyle(.primary)
                .multilineTextAlignment(.center)
                .clipShape(RoundedRectangle(cornerRadius: 12))

                Picker("Model", selection: $isSimpleMode) {
                    Text("Simple").tag(true)
                    Text("Multi").tag(false)
                }
                .pickerStyle(.segmented)
                .font(.title2.bold())
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                Form {
                    Section(header: Text("Input")) {
                        if isSimpleMode {
                            HStack {
                                 Text("Fare:")
                                 TextField("0.0", value: $simpleModel.fare, format: .number)
                                    .onChange(of: simpleModel.fare) {
                                        simpleModel.predictPrice()
                                    }
                                    .keyboardType(.decimalPad)
                                    .multilineTextAlignment(.trailing)
                             }
                        }
                        else
                            {
                            HStack {
                                Text("Fare:")
                                TextField("0.0",value: $multiModel.fare, format: .number)
                                    .onChange(of: multiModel.fare) {
                                        multiModel.predictPrice()
                                    }
                                    .keyboardType(.decimalPad)
                                    .multilineTextAlignment(.trailing)
                             }
                            HStack {
                                Text("Tip:")
                                TextField("0.0",value: $multiModel.tip, format: .number)
                                    .onChange(of: multiModel.tip) {
                                        multiModel.predictPrice()
                                    }
                                    .keyboardType(.decimalPad)
                                    .multilineTextAlignment(.trailing)
                             }
                            HStack {
                                Text("miscellaneous Fees:")
                                TextField("0.0",value: $multiModel.miscellaneousFees, format: .number)
                                    .onChange(of: multiModel.miscellaneousFees) {
                                        multiModel.predictPrice()
                                    }
                                    .keyboardType(.decimalPad)
                                    .multilineTextAlignment(.trailing)
                            }
                           
                        }
                    }
                    Button("Predict total fare") {
                        if isSimpleMode {
                            simpleModel.predictPrice()
                        } else {
                            multiModel.predictPrice()
                        }
                    }
                    .disabled(!isPredictEnabled)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .buttonStyle(.borderedProminent)
                    .padding(.top, 10)
                    
                    Section(header: Text("Output")) {
                        if !isPredictEnabled {
                            Text("Veuillez remplir les champs.")
                        }
                        else
                        {
                            if isSimpleMode {
                                Text("Fare estimated : $\(simpleModel.predictedPrice ?? 0, specifier: "%.2f")")
                            } else {
                                Text("Fare estimated : $\(multiModel.predictedPrice ?? 0, specifier: "%.2f")")
                            }
                        }
                    }
                    .foregroundStyle(.green)
                    .font(.headline.weight(.bold))
                }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
