//
//  PosteriorCoronals.swift
//  goliath
//
//  Created by Christophe Beaulieu on 2025-08-19.
//

import SwiftUI

extension MusculoDiagramsView {
    struct PosteriorCoronal: View {
        private let muscleGroups: [MuscleGroup]

        init(presenting muscleGroups: [MuscleGroup]) {
            let allUniqueGroups = Set(muscleGroups + MuscleGroup.allCases)
            self.muscleGroups = Array(allUniqueGroups)
        }

        var body: some View {
            Color.clear
                .overlay {
                    MusculoDiagramsView.Body()
                        .aspectRatio(MusculoDiagramsView.bodyAspectRatio, contentMode: .fit)
                        .scaleEffect(MusculoDiagramsView.bodyScalingFactor)
                    ForEach(muscleGroups, id: \.hashValue) { muscleGroup in
                        switch muscleGroup {
                        case .abductors(let disabled, let action): MusculoDiagramsView.draw(muscleGroup: Abductors(), disabled: disabled, onTapPerform: action)
                        case .adductors(let disabled, let action): MusculoDiagramsView.draw(muscleGroup: Adductors(), disabled: disabled, onTapPerform: action)
                        case .calves(let disabled, let action): MusculoDiagramsView.draw(muscleGroup: Calves(), disabled: disabled, onTapPerform: action)
                        case .deltoids(let disabled, let action): MusculoDiagramsView.draw(muscleGroup: Deltoids(), disabled: disabled, onTapPerform: action)
                        case .forearms(let disabled, let action): MusculoDiagramsView.draw(muscleGroup: Forearms(), disabled: disabled, onTapPerform: action)
                        case .glutes(let disabled, let action): MusculoDiagramsView.draw(muscleGroup: Glutes(), disabled: disabled, onTapPerform: action)
                        case .hamstrings(let disabled, let action): MusculoDiagramsView.draw(muscleGroup: Hamstrings(), disabled: disabled, onTapPerform: action)
                        case .laterals(let disabled, let action): MusculoDiagramsView.draw(muscleGroup: Laterals(), disabled: disabled, onTapPerform: action)
                        case .lumbars(let disabled, let action): MusculoDiagramsView.draw(muscleGroup: Lumbars(), disabled: disabled, onTapPerform: action)
                        case .obliques(let disabled, let action): MusculoDiagramsView.draw(muscleGroup: Obliques(), disabled: disabled, onTapPerform: action)
                        case .trapezii(let disabled, let action): MusculoDiagramsView.draw(muscleGroup: Trapezii(), disabled: disabled, onTapPerform: action)
                        case .triceps(let disabled, let action): MusculoDiagramsView.draw(muscleGroup: Triceps(), disabled: disabled, onTapPerform: action)
                        default: EmptyView()
                        }
                    }
                    .aspectRatio(MusculoDiagramsView.bodyAspectRatio, contentMode: .fit)
                    .scaleEffect(MusculoDiagramsView.bodyScalingFactor)
                }
                .aspectRatio(MusculoDiagramsView.coronalAspectRatio, contentMode: .fit)
                .clipped()
        }

        struct Abductors: Shape {
            func path(in rect: CGRect) -> Path {
                var path = Path()
                path.addPath(TensorFascieLatae().path(in: rect))
                return path
                    .offsetBy(dx: 0.0075*rect.size.width, dy: -0.006*rect.size.height)
            }

            struct TensorFascieLatae: Shape {
                func path(in rect: CGRect) -> Path {
                    var path = Path()
                    let width = rect.size.width
                    let height = rect.size.height
                    path.move(to: CGPoint(x: 0.57519*width, y: 0.48255*height))
                    path.addCurve(to: CGPoint(x: 0.59347*width, y: 0.49281*height), control1: CGPoint(x: 0.57519*width, y: 0.48255*height), control2: CGPoint(x: 0.58322*width, y: 0.48389*height))
                    path.addCurve(to: CGPoint(x: 0.59727*width, y: 0.50412*height), control1: CGPoint(x: 0.59391*width, y: 0.49444*height), control2: CGPoint(x: 0.59569*width, y: 0.49906*height))
                    path.addCurve(to: CGPoint(x: 0.61556*width, y: 0.57299*height), control1: CGPoint(x: 0.59884*width, y: 0.50918*height), control2: CGPoint(x: 0.61444*width, y: 0.53772*height))
                    path.addCurve(to: CGPoint(x: 0.61199*width, y: 0.62535*height), control1: CGPoint(x: 0.6163*width, y: 0.5965*height), control2: CGPoint(x: 0.61361*width, y: 0.60994*height))
                    path.addCurve(to: CGPoint(x: 0.59972*width, y: 0.57566*height), control1: CGPoint(x: 0.60759*width, y: 0.61316*height), control2: CGPoint(x: 0.6053*width, y: 0.59144*height))
                    path.addCurve(to: CGPoint(x: 0.58299*width, y: 0.54145*height), control1: CGPoint(x: 0.59414*width, y: 0.55989*height), control2: CGPoint(x: 0.58701*width, y: 0.54472*height))
                    path.addCurve(to: CGPoint(x: 0.5765*width, y: 0.52478*height), control1: CGPoint(x: 0.58275*width, y: 0.53877*height), control2: CGPoint(x: 0.58208*width, y: 0.53594*height))
                    path.addCurve(to: CGPoint(x: 0.57382*width, y: 0.48849*height), control1: CGPoint(x: 0.57093*width, y: 0.51363*height), control2: CGPoint(x: 0.5638*width, y: 0.50262*height))
                    path.addCurve(to: CGPoint(x: 0.57519*width, y: 0.48255*height), control1: CGPoint(x: 0.57519*width, y: 0.48657*height), control2: CGPoint(x: 0.57653*width, y: 0.48583*height))
                    path.closeSubpath()
                    path.move(to: CGPoint(x: 0.40926*width, y: 0.48295*height))
                    path.addCurve(to: CGPoint(x: 0.39097*width, y: 0.49321*height), control1: CGPoint(x: 0.40926*width, y: 0.48295*height), control2: CGPoint(x: 0.40123*width, y: 0.48429*height))
                    path.addCurve(to: CGPoint(x: 0.38718*width, y: 0.50452*height), control1: CGPoint(x: 0.39053*width, y: 0.49485*height), control2: CGPoint(x: 0.38875*width, y: 0.49946*height))
                    path.addCurve(to: CGPoint(x: 0.36889*width, y: 0.5734*height), control1: CGPoint(x: 0.38563*width, y: 0.50958*height), control2: CGPoint(x: 0.37*width, y: 0.53812*height))
                    path.addCurve(to: CGPoint(x: 0.37245*width, y: 0.62576*height), control1: CGPoint(x: 0.36815*width, y: 0.5969*height), control2: CGPoint(x: 0.37083*width, y: 0.61034*height))
                    path.addCurve(to: CGPoint(x: 0.38472*width, y: 0.57606*height), control1: CGPoint(x: 0.37685*width, y: 0.61356*height), control2: CGPoint(x: 0.37914*width, y: 0.59184*height))
                    path.addCurve(to: CGPoint(x: 0.40146*width, y: 0.54185*height), control1: CGPoint(x: 0.3903*width, y: 0.56029*height), control2: CGPoint(x: 0.39743*width, y: 0.54512*height))
                    path.addCurve(to: CGPoint(x: 0.40794*width, y: 0.52519*height), control1: CGPoint(x: 0.40169*width, y: 0.53917*height), control2: CGPoint(x: 0.40236*width, y: 0.53634*height))
                    path.addCurve(to: CGPoint(x: 0.41063*width, y: 0.48889*height), control1: CGPoint(x: 0.41352*width, y: 0.51403*height), control2: CGPoint(x: 0.42065*width, y: 0.50302*height))
                    path.addCurve(to: CGPoint(x: 0.40926*width, y: 0.48295*height), control1: CGPoint(x: 0.40926*width, y: 0.48696*height), control2: CGPoint(x: 0.40792*width, y: 0.48622*height))
                    path.closeSubpath()
                    return path
                }
            }
        }

        struct Adductors: Shape {
            func path(in rect: CGRect) -> Path {
                var path = Path()
                path.addPath(AdductorMagnus().path(in: rect))
                return path
                    .offsetBy(dx: 0.0075*rect.size.width, dy: -0.005*rect.size.height)
            }

            struct AdductorMagnus: Shape {
                func path(in rect: CGRect) -> Path {
                    var path = Path()
                    let width = rect.size.width
                    let height = rect.size.height
                    path.move(to: CGPoint(x: 0.48926*width, y: 0.54296*height))
                    path.addCurve(to: CGPoint(x: 0.48333*width, y: 0.56164*height), control1: CGPoint(x: 0.4885*width, y: 0.54698*height), control2: CGPoint(x: 0.48609*width, y: 0.55378*height))
                    path.addCurve(to: CGPoint(x: 0.47169*width, y: 0.60049*height), control1: CGPoint(x: 0.47924*width, y: 0.57324*height), control2: CGPoint(x: 0.47417*width, y: 0.58767*height))
                    path.addCurve(to: CGPoint(x: 0.4681*width, y: 0.62378*height), control1: CGPoint(x: 0.47032*width, y: 0.6075*height), control2: CGPoint(x: 0.46917*width, y: 0.61569*height))
                    path.addCurve(to: CGPoint(x: 0.4631*width, y: 0.53765*height), control1: CGPoint(x: 0.45912*width, y: 0.59508*height), control2: CGPoint(x: 0.44785*width, y: 0.56608*height))
                    path.addCurve(to: CGPoint(x: 0.48722*width, y: 0.52573*height), control1: CGPoint(x: 0.47269*width, y: 0.53514*height), control2: CGPoint(x: 0.48137*width, y: 0.53173*height))
                    path.addCurve(to: CGPoint(x: 0.48836*width, y: 0.5244*height), control1: CGPoint(x: 0.48764*width, y: 0.52529*height), control2: CGPoint(x: 0.48801*width, y: 0.52486*height))
                    path.addCurve(to: CGPoint(x: 0.48926*width, y: 0.54296*height), control1: CGPoint(x: 0.48912*width, y: 0.52748*height), control2: CGPoint(x: 0.49072*width, y: 0.53531*height))
                    path.move(to: CGPoint(x: 0.49532*width, y: 0.54296*height))
                    path.addCurve(to: CGPoint(x: 0.50144*width, y: 0.56164*height), control1: CGPoint(x: 0.49611*width, y: 0.54698*height), control2: CGPoint(x: 0.49859*width, y: 0.55378*height))
                    path.addCurve(to: CGPoint(x: 0.51343*width, y: 0.60049*height), control1: CGPoint(x: 0.50565*width, y: 0.57324*height), control2: CGPoint(x: 0.51088*width, y: 0.58767*height))
                    path.addCurve(to: CGPoint(x: 0.51713*width, y: 0.62378*height), control1: CGPoint(x: 0.51481*width, y: 0.6075*height), control2: CGPoint(x: 0.51602*width, y: 0.61569*height))
                    path.addCurve(to: CGPoint(x: 0.52227*width, y: 0.53765*height), control1: CGPoint(x: 0.52639*width, y: 0.59508*height), control2: CGPoint(x: 0.53799*width, y: 0.56608*height))
                    path.addCurve(to: CGPoint(x: 0.49743*width, y: 0.52573*height), control1: CGPoint(x: 0.51241*width, y: 0.53514*height), control2: CGPoint(x: 0.50347*width, y: 0.53173*height))
                    path.addCurve(to: CGPoint(x: 0.49625*width, y: 0.5244*height), control1: CGPoint(x: 0.49699*width, y: 0.52529*height), control2: CGPoint(x: 0.49662*width, y: 0.52486*height))
                    path.addCurve(to: CGPoint(x: 0.49532*width, y: 0.54296*height), control1: CGPoint(x: 0.49546*width, y: 0.52748*height), control2: CGPoint(x: 0.49382*width, y: 0.53531*height))
                    return path
                        .scale(0.98).path(in: rect)
                }
            }
        }

        struct Calves: Shape {
            func path(in rect: CGRect) -> Path {
                var path = Path()
                path.addPath(GastrocnemiusLateralHead().path(in: rect))
                path.addPath(GastrocnemiusMedialHead().path(in: rect))
                path.addPath(PeroneusLongus().path(in: rect))
                return path
                    .offsetBy(dx: 0.008*rect.size.width, dy: -0.005*rect.size.height)
            }

            struct GastrocnemiusLateralHead: Shape {
                func path(in rect: CGRect) -> Path {
                    var path = Path()
                    let width = rect.size.width
                    let height = rect.size.height
                    path.move(to: CGPoint(x: 0.41463*width, y: 0.70438*height))
                    path.addCurve(to: CGPoint(x: 0.4047*width, y: 0.74005*height), control1: CGPoint(x: 0.40891*width, y: 0.71565*height), control2: CGPoint(x: 0.40583*width, y: 0.72761*height))
                    path.addCurve(to: CGPoint(x: 0.40359*width, y: 0.76644*height), control1: CGPoint(x: 0.40391*width, y: 0.7488*height), control2: CGPoint(x: 0.40361*width, y: 0.75762*height))
                    path.addCurve(to: CGPoint(x: 0.37972*width, y: 0.76196*height), control1: CGPoint(x: 0.39685*width, y: 0.77236*height), control2: CGPoint(x: 0.38167*width, y: 0.77046*height))
                    path.addLine(to: CGPoint(x: 0.37961*width, y: 0.76176*height))
                    path.addCurve(to: CGPoint(x: 0.37523*width, y: 0.70117*height), control1: CGPoint(x: 0.37481*width, y: 0.7416*height), control2: CGPoint(x: 0.37132*width, y: 0.72139*height))
                    path.addLine(to: CGPoint(x: 0.37542*width, y: 0.70086*height))
                    path.addCurve(to: CGPoint(x: 0.38868*width, y: 0.67599*height), control1: CGPoint(x: 0.37861*width, y: 0.69451*height), control2: CGPoint(x: 0.38461*width, y: 0.68346*height))
                    path.addLine(to: CGPoint(x: 0.3888*width, y: 0.67582*height))
                    path.addCurve(to: CGPoint(x: 0.39461*width, y: 0.66679*height), control1: CGPoint(x: 0.39076*width, y: 0.67282*height), control2: CGPoint(x: 0.39271*width, y: 0.6698*height))
                    path.addCurve(to: CGPoint(x: 0.41463*width, y: 0.70438*height), control1: CGPoint(x: 0.40824*width, y: 0.67738*height), control2: CGPoint(x: 0.41523*width, y: 0.69049*height))
                    path.move(to: CGPoint(x: 0.56988*width, y: 0.70438*height))
                    path.addCurve(to: CGPoint(x: 0.57981*width, y: 0.74005*height), control1: CGPoint(x: 0.5756*width, y: 0.71565*height), control2: CGPoint(x: 0.57868*width, y: 0.72761*height))
                    path.addCurve(to: CGPoint(x: 0.58093*width, y: 0.76644*height), control1: CGPoint(x: 0.5806*width, y: 0.7488*height), control2: CGPoint(x: 0.58088*width, y: 0.75762*height))
                    path.addCurve(to: CGPoint(x: 0.60479*width, y: 0.76196*height), control1: CGPoint(x: 0.58766*width, y: 0.77236*height), control2: CGPoint(x: 0.60285*width, y: 0.77046*height))
                    path.addLine(to: CGPoint(x: 0.60491*width, y: 0.76176*height))
                    path.addCurve(to: CGPoint(x: 0.60928*width, y: 0.70117*height), control1: CGPoint(x: 0.6097*width, y: 0.7416*height), control2: CGPoint(x: 0.61319*width, y: 0.72139*height))
                    path.addLine(to: CGPoint(x: 0.6091*width, y: 0.70086*height))
                    path.addCurve(to: CGPoint(x: 0.59583*width, y: 0.67599*height), control1: CGPoint(x: 0.6059*width, y: 0.69451*height), control2: CGPoint(x: 0.59991*width, y: 0.68346*height))
                    path.addLine(to: CGPoint(x: 0.59572*width, y: 0.67582*height))
                    path.addCurve(to: CGPoint(x: 0.58991*width, y: 0.66679*height), control1: CGPoint(x: 0.59375*width, y: 0.67282*height), control2: CGPoint(x: 0.59181*width, y: 0.6698*height))
                    path.addCurve(to: CGPoint(x: 0.56988*width, y: 0.70438*height), control1: CGPoint(x: 0.57625*width, y: 0.67738*height), control2: CGPoint(x: 0.56928*width, y: 0.69049*height))
                    return path
                        .scale(0.99).path(in: rect)
                        .offsetBy(dx: 0.000*rect.size.width, dy: 0.000*rect.size.height)
                }
            }

            struct GastrocnemiusMedialHead: Shape {
                func path(in rect: CGRect) -> Path {
                    var path = Path()
                    let width = rect.size.width
                    let height = rect.size.height
                    path.move(to: CGPoint(x: 0.52998*width, y: 0.73043*height))
                    path.addCurve(to: CGPoint(x: 0.53437*width, y: 0.74355*height), control1: CGPoint(x: 0.52998*width, y: 0.73477*height), control2: CGPoint(x: 0.53222*width, y: 0.73924*height))
                    path.addCurve(to: CGPoint(x: 0.53741*width, y: 0.75019*height), control1: CGPoint(x: 0.53549*width, y: 0.74576*height), control2: CGPoint(x: 0.53662*width, y: 0.74804*height))
                    path.addLine(to: CGPoint(x: 0.53951*width, y: 0.75341*height))
                    path.addCurve(to: CGPoint(x: 0.55493*width, y: 0.77827*height), control1: CGPoint(x: 0.54491*width, y: 0.7616*height), control2: CGPoint(x: 0.55035*width, y: 0.76986*height))
                    path.addCurve(to: CGPoint(x: 0.57808*width, y: 0.77659*height), control1: CGPoint(x: 0.56134*width, y: 0.78412*height), control2: CGPoint(x: 0.57424*width, y: 0.78265*height))
                    path.addLine(to: CGPoint(x: 0.57808*width, y: 0.77657*height))
                    path.addCurve(to: CGPoint(x: 0.57729*width, y: 0.74409*height), control1: CGPoint(x: 0.5781*width, y: 0.76573*height), control2: CGPoint(x: 0.57785*width, y: 0.75491*height))
                    path.addCurve(to: CGPoint(x: 0.56745*width, y: 0.70631*height), control1: CGPoint(x: 0.5766*width, y: 0.73096*height), control2: CGPoint(x: 0.57352*width, y: 0.71826*height))
                    path.addLine(to: CGPoint(x: 0.56715*width, y: 0.70576*height))
                    path.addCurve(to: CGPoint(x: 0.54826*width, y: 0.68071*height), control1: CGPoint(x: 0.56259*width, y: 0.69693*height), control2: CGPoint(x: 0.55639*width, y: 0.68855*height))
                    path.addCurve(to: CGPoint(x: 0.54525*width, y: 0.68662*height), control1: CGPoint(x: 0.54708*width, y: 0.68276*height), control2: CGPoint(x: 0.54604*width, y: 0.68474*height))
                    path.addCurve(to: CGPoint(x: 0.53664*width, y: 0.71162*height), control1: CGPoint(x: 0.54461*width, y: 0.69556*height), control2: CGPoint(x: 0.54025*width, y: 0.70344*height))
                    path.addCurve(to: CGPoint(x: 0.52998*width, y: 0.73043*height), control1: CGPoint(x: 0.53375*width, y: 0.71813*height), control2: CGPoint(x: 0.531*width, y: 0.72429*height))
                    path.move(to: CGPoint(x: 0.45194*width, y: 0.73043*height))
                    path.addCurve(to: CGPoint(x: 0.44755*width, y: 0.74355*height), control1: CGPoint(x: 0.45194*width, y: 0.73477*height), control2: CGPoint(x: 0.4497*width, y: 0.73924*height))
                    path.addCurve(to: CGPoint(x: 0.44451*width, y: 0.75019*height), control1: CGPoint(x: 0.44644*width, y: 0.74576*height), control2: CGPoint(x: 0.4453*width, y: 0.74804*height))
                    path.addLine(to: CGPoint(x: 0.44241*width, y: 0.75341*height))
                    path.addCurve(to: CGPoint(x: 0.42699*width, y: 0.77827*height), control1: CGPoint(x: 0.43701*width, y: 0.7616*height), control2: CGPoint(x: 0.43157*width, y: 0.76986*height))
                    path.addCurve(to: CGPoint(x: 0.40384*width, y: 0.77659*height), control1: CGPoint(x: 0.42058*width, y: 0.78412*height), control2: CGPoint(x: 0.40769*width, y: 0.78265*height))
                    path.addLine(to: CGPoint(x: 0.40384*width, y: 0.77657*height))
                    path.addCurve(to: CGPoint(x: 0.40463*width, y: 0.74409*height), control1: CGPoint(x: 0.40382*width, y: 0.76573*height), control2: CGPoint(x: 0.40407*width, y: 0.75491*height))
                    path.addCurve(to: CGPoint(x: 0.41447*width, y: 0.70631*height), control1: CGPoint(x: 0.40532*width, y: 0.73096*height), control2: CGPoint(x: 0.4084*width, y: 0.71826*height))
                    path.addLine(to: CGPoint(x: 0.41477*width, y: 0.70576*height))
                    path.addCurve(to: CGPoint(x: 0.43366*width, y: 0.68071*height), control1: CGPoint(x: 0.41933*width, y: 0.69693*height), control2: CGPoint(x: 0.42553*width, y: 0.68855*height))
                    path.addCurve(to: CGPoint(x: 0.43667*width, y: 0.68662*height), control1: CGPoint(x: 0.43484*width, y: 0.68276*height), control2: CGPoint(x: 0.43588*width, y: 0.68474*height))
                    path.addCurve(to: CGPoint(x: 0.44528*width, y: 0.71162*height), control1: CGPoint(x: 0.43731*width, y: 0.69556*height), control2: CGPoint(x: 0.44167*width, y: 0.70344*height))
                    path.addCurve(to: CGPoint(x: 0.45194*width, y: 0.73043*height), control1: CGPoint(x: 0.44817*width, y: 0.71813*height), control2: CGPoint(x: 0.4509*width, y: 0.72429*height))
                    return path
                        .scale(0.99).path(in: rect)
                        .offsetBy(dx: 0.0015*rect.size.width, dy: -0.0025*rect.size.height)
                }
            }

            struct PeroneusLongus: Shape {
                func path(in rect: CGRect) -> Path {
                    var path = Path()
                    let width = rect.size.width
                    let height = rect.size.height
                    path.move(to: CGPoint(x: 0.38694*width, y: 0.81441*height))
                    path.addLine(to: CGPoint(x: 0.38694*width, y: 0.81443*height))
                    path.addCurve(to: CGPoint(x: 0.37273*width, y: 0.83216*height), control1: CGPoint(x: 0.38412*width, y: 0.82103*height), control2: CGPoint(x: 0.37935*width, y: 0.82699*height))
                    path.addCurve(to: CGPoint(x: 0.37525*width, y: 0.82684*height), control1: CGPoint(x: 0.37356*width, y: 0.83069*height), control2: CGPoint(x: 0.37442*width, y: 0.82895*height))
                    path.addCurve(to: CGPoint(x: 0.37567*width, y: 0.79599*height), control1: CGPoint(x: 0.37919*width, y: 0.81694*height), control2: CGPoint(x: 0.37738*width, y: 0.80628*height))
                    path.addLine(to: CGPoint(x: 0.37544*width, y: 0.79465*height))
                    path.addCurve(to: CGPoint(x: 0.37093*width, y: 0.77758*height), control1: CGPoint(x: 0.3741*width, y: 0.78895*height), control2: CGPoint(x: 0.37248*width, y: 0.78318*height))
                    path.addCurve(to: CGPoint(x: 0.3706*width, y: 0.70483*height), control1: CGPoint(x: 0.36387*width, y: 0.75225*height), control2: CGPoint(x: 0.35718*width, y: 0.72829*height))
                    path.addCurve(to: CGPoint(x: 0.37572*width, y: 0.76248*height), control1: CGPoint(x: 0.36771*width, y: 0.72407*height), control2: CGPoint(x: 0.37116*width, y: 0.74329*height))
                    path.addLine(to: CGPoint(x: 0.37572*width, y: 0.76252*height))
                    path.addLine(to: CGPoint(x: 0.37572*width, y: 0.76261*height))
                    path.addCurve(to: CGPoint(x: 0.3759*width, y: 0.76324*height), control1: CGPoint(x: 0.37576*width, y: 0.76282*height), control2: CGPoint(x: 0.37583*width, y: 0.76302*height))
                    path.addCurve(to: CGPoint(x: 0.38694*width, y: 0.81441*height), control1: CGPoint(x: 0.38005*width, y: 0.78032*height), control2: CGPoint(x: 0.38495*width, y: 0.79739*height))
                    path.move(to: CGPoint(x: 0.59285*width, y: 0.81441*height))
                    path.addLine(to: CGPoint(x: 0.59285*width, y: 0.81443*height))
                    path.addCurve(to: CGPoint(x: 0.60706*width, y: 0.83216*height), control1: CGPoint(x: 0.59567*width, y: 0.82103*height), control2: CGPoint(x: 0.60044*width, y: 0.82699*height))
                    path.addCurve(to: CGPoint(x: 0.60454*width, y: 0.82684*height), control1: CGPoint(x: 0.60623*width, y: 0.83069*height), control2: CGPoint(x: 0.60537*width, y: 0.82895*height))
                    path.addCurve(to: CGPoint(x: 0.60412*width, y: 0.79599*height), control1: CGPoint(x: 0.6006*width, y: 0.81694*height), control2: CGPoint(x: 0.60241*width, y: 0.80628*height))
                    path.addLine(to: CGPoint(x: 0.60435*width, y: 0.79465*height))
                    path.addCurve(to: CGPoint(x: 0.60887*width, y: 0.77758*height), control1: CGPoint(x: 0.60569*width, y: 0.78895*height), control2: CGPoint(x: 0.60731*width, y: 0.78318*height))
                    path.addCurve(to: CGPoint(x: 0.60919*width, y: 0.70483*height), control1: CGPoint(x: 0.61593*width, y: 0.75225*height), control2: CGPoint(x: 0.62262*width, y: 0.72829*height))
                    path.addCurve(to: CGPoint(x: 0.60407*width, y: 0.76248*height), control1: CGPoint(x: 0.61208*width, y: 0.72407*height), control2: CGPoint(x: 0.60863*width, y: 0.74329*height))
                    path.addLine(to: CGPoint(x: 0.60407*width, y: 0.76252*height))
                    path.addLine(to: CGPoint(x: 0.60407*width, y: 0.76261*height))
                    path.addCurve(to: CGPoint(x: 0.60389*width, y: 0.76324*height), control1: CGPoint(x: 0.60403*width, y: 0.76282*height), control2: CGPoint(x: 0.60396*width, y: 0.76302*height))
                    path.addCurve(to: CGPoint(x: 0.59285*width, y: 0.81441*height), control1: CGPoint(x: 0.59975*width, y: 0.78032*height), control2: CGPoint(x: 0.59484*width, y: 0.79739*height))
                    return path
                        .offsetBy(dx: 0.0025*rect.size.width, dy: -0.002*rect.size.height)
                }
            }
        }

        struct Forearms: Shape {
            func path(in rect: CGRect) -> Path {
                var path = Path()
                path.addPath(Brachioradialis().path(in: rect))
                path.addPath(ExtensorCarpiRadialis().path(in: rect))
                path.addPath(FlexorCarpiRadialis().path(in: rect))
                path.addPath(FlexorCarpiUlnaris().path(in: rect))
                return path
                    .offsetBy(dx: 0.0075*rect.size.width, dy: -0.004*rect.size.height)
            }

            struct Brachioradialis: Shape {
                func path(in rect: CGRect) -> Path {
                    var path = Path()
                    let width = rect.size.width
                    let height = rect.size.height
                    path.move(to: CGPoint(x: 0.67326*width, y: 0.36282*height))
                    path.addCurve(to: CGPoint(x: 0.69081*width, y: 0.40628*height), control1: CGPoint(x: 0.67326*width, y: 0.36282*height), control2: CGPoint(x: 0.69435*width, y: 0.37796*height))
                    path.addCurve(to: CGPoint(x: 0.67148*width, y: 0.39281*height), control1: CGPoint(x: 0.68771*width, y: 0.40392*height), control2: CGPoint(x: 0.67532*width, y: 0.39586*height))
                    path.addCurve(to: CGPoint(x: 0.66308*width, y: 0.3817*height), control1: CGPoint(x: 0.66764*width, y: 0.38977*height), control2: CGPoint(x: 0.66396*width, y: 0.38386*height))
                    path.addCurve(to: CGPoint(x: 0.67326*width, y: 0.36282*height), control1: CGPoint(x: 0.66456*width, y: 0.37924*height), control2: CGPoint(x: 0.67282*width, y: 0.36548*height))
                    path.closeSubpath()
                    path.move(to: CGPoint(x: 0.31062*width, y: 0.36361*height))
                    path.addCurve(to: CGPoint(x: 0.29308*width, y: 0.40707*height), control1: CGPoint(x: 0.31062*width, y: 0.36361*height), control2: CGPoint(x: 0.28954*width, y: 0.37875*height))
                    path.addCurve(to: CGPoint(x: 0.31241*width, y: 0.3936*height), control1: CGPoint(x: 0.29618*width, y: 0.40471*height), control2: CGPoint(x: 0.30856*width, y: 0.39665*height))
                    path.addCurve(to: CGPoint(x: 0.32081*width, y: 0.38248*height), control1: CGPoint(x: 0.31625*width, y: 0.39056*height), control2: CGPoint(x: 0.31993*width, y: 0.38465*height))
                    path.addCurve(to: CGPoint(x: 0.31062*width, y: 0.36361*height), control1: CGPoint(x: 0.31931*width, y: 0.38003*height), control2: CGPoint(x: 0.31106*width, y: 0.36627*height))
                    path.closeSubpath()
                    return path
                        .scale(0.985).path(in: rect)
                        .offsetBy(dx: 0*rect.size.width, dy: -0.002*rect.size.height)
                }
            }

            struct ExtensorCarpiRadialis: Shape {
                func path(in rect: CGRect) -> Path {
                    var path = Path()
                    let width = rect.size.width
                    let height = rect.size.height
                    path.move(to: CGPoint(x: 0.32655*width, y: 0.38918*height))
                    path.addCurve(to: CGPoint(x: 0.30243*width, y: 0.42886*height), control1: CGPoint(x: 0.32238*width, y: 0.40355*height), control2: CGPoint(x: 0.31174*width, y: 0.41568*height))
                    path.addCurve(to: CGPoint(x: 0.2916*width, y: 0.46117*height), control1: CGPoint(x: 0.2956*width, y: 0.43855*height), control2: CGPoint(x: 0.29278*width, y: 0.45062*height))
                    path.addCurve(to: CGPoint(x: 0.28995*width, y: 0.45264*height), control1: CGPoint(x: 0.29118*width, y: 0.45884*height), control2: CGPoint(x: 0.29039*width, y: 0.45492*height))
                    path.addCurve(to: CGPoint(x: 0.28711*width, y: 0.43375*height), control1: CGPoint(x: 0.2888*width, y: 0.44627*height), control2: CGPoint(x: 0.28769*width, y: 0.44025*height))
                    path.addCurve(to: CGPoint(x: 0.29391*width, y: 0.4073*height), control1: CGPoint(x: 0.28558*width, y: 0.41699*height), control2: CGPoint(x: 0.29292*width, y: 0.40836*height))
                    path.addLine(to: CGPoint(x: 0.29403*width, y: 0.40718*height))
                    path.addCurve(to: CGPoint(x: 0.32104*width, y: 0.38346*height), control1: CGPoint(x: 0.30306*width, y: 0.39915*height), control2: CGPoint(x: 0.31727*width, y: 0.39332*height))
                    path.addCurve(to: CGPoint(x: 0.32329*width, y: 0.38674*height), control1: CGPoint(x: 0.32178*width, y: 0.3846*height), control2: CGPoint(x: 0.32252*width, y: 0.38568*height))
                    path.addCurve(to: CGPoint(x: 0.32655*width, y: 0.38918*height), control1: CGPoint(x: 0.32419*width, y: 0.38804*height), control2: CGPoint(x: 0.32532*width, y: 0.3888*height))
                    path.move(to: CGPoint(x: 0.65639*width, y: 0.38918*height))
                    path.addCurve(to: CGPoint(x: 0.68051*width, y: 0.42886*height), control1: CGPoint(x: 0.66056*width, y: 0.40355*height), control2: CGPoint(x: 0.6712*width, y: 0.41568*height))
                    path.addCurve(to: CGPoint(x: 0.69134*width, y: 0.46117*height), control1: CGPoint(x: 0.68734*width, y: 0.43855*height), control2: CGPoint(x: 0.69016*width, y: 0.45062*height))
                    path.addCurve(to: CGPoint(x: 0.69299*width, y: 0.45264*height), control1: CGPoint(x: 0.69176*width, y: 0.45884*height), control2: CGPoint(x: 0.69255*width, y: 0.45492*height))
                    path.addCurve(to: CGPoint(x: 0.69583*width, y: 0.43375*height), control1: CGPoint(x: 0.69414*width, y: 0.44627*height), control2: CGPoint(x: 0.69525*width, y: 0.44025*height))
                    path.addCurve(to: CGPoint(x: 0.68903*width, y: 0.4073*height), control1: CGPoint(x: 0.69736*width, y: 0.41699*height), control2: CGPoint(x: 0.69002*width, y: 0.40836*height))
                    path.addLine(to: CGPoint(x: 0.68891*width, y: 0.40718*height))
                    path.addCurve(to: CGPoint(x: 0.6619*width, y: 0.38346*height), control1: CGPoint(x: 0.67988*width, y: 0.39915*height), control2: CGPoint(x: 0.66567*width, y: 0.39332*height))
                    path.addCurve(to: CGPoint(x: 0.65965*width, y: 0.38674*height), control1: CGPoint(x: 0.66116*width, y: 0.3846*height), control2: CGPoint(x: 0.66042*width, y: 0.38568*height))
                    path.addCurve(to: CGPoint(x: 0.65639*width, y: 0.38918*height), control1: CGPoint(x: 0.65875*width, y: 0.38804*height), control2: CGPoint(x: 0.65762*width, y: 0.3888*height))
                    return path
                        .scale(0.985).path(in: rect)
                        .offsetBy(dx: 0.0005*rect.size.width, dy: -0.0025*rect.size.height)
                }
            }

            struct FlexorCarpiRadialis: Shape {
                func path(in rect: CGRect) -> Path {
                    var path = Path()
                    let width = rect.size.width
                    let height = rect.size.height
                    path.move(to: CGPoint(x: 0.35604*width, y: 0.40222*height))
                    path.addCurve(to: CGPoint(x: 0.32926*width, y: 0.49069*height), control1: CGPoint(x: 0.32799*width, y: 0.42569*height), control2: CGPoint(x: 0.31771*width, y: 0.46157*height))
                    path.addLine(to: CGPoint(x: 0.32926*width, y: 0.49071*height))
                    path.addCurve(to: CGPoint(x: 0.33417*width, y: 0.47301*height), control1: CGPoint(x: 0.33019*width, y: 0.48748*height), control2: CGPoint(x: 0.3312*width, y: 0.48043*height))
                    path.addCurve(to: CGPoint(x: 0.34505*width, y: 0.45242*height), control1: CGPoint(x: 0.33713*width, y: 0.46557*height), control2: CGPoint(x: 0.34201*width, y: 0.45776*height))
                    path.addCurve(to: CGPoint(x: 0.35928*width, y: 0.42085*height), control1: CGPoint(x: 0.35194*width, y: 0.44025*height), control2: CGPoint(x: 0.35882*width, y: 0.42815*height))
                    path.addCurve(to: CGPoint(x: 0.35736*width, y: 0.40373*height), control1: CGPoint(x: 0.36*width, y: 0.40952*height), control2: CGPoint(x: 0.35817*width, y: 0.40535*height))
                    path.addCurve(to: CGPoint(x: 0.35604*width, y: 0.40222*height), control1: CGPoint(x: 0.35736*width, y: 0.40373*height), control2: CGPoint(x: 0.35606*width, y: 0.40222*height))
                    path.closeSubpath()
                    path.move(to: CGPoint(x: 0.6297*width, y: 0.40224*height))
                    path.addCurve(to: CGPoint(x: 0.65674*width, y: 0.49039*height), control1: CGPoint(x: 0.65775*width, y: 0.42571*height), control2: CGPoint(x: 0.66829*width, y: 0.46127*height))
                    path.addLine(to: CGPoint(x: 0.65674*width, y: 0.4904*height))
                    path.addCurve(to: CGPoint(x: 0.65435*width, y: 0.47986*height), control1: CGPoint(x: 0.65646*width, y: 0.49111*height), control2: CGPoint(x: 0.65546*width, y: 0.4858*height))
                    path.addCurve(to: CGPoint(x: 0.64127*width, y: 0.45225*height), control1: CGPoint(x: 0.65319*width, y: 0.47369*height), control2: CGPoint(x: 0.64734*width, y: 0.46293*height))
                    path.addCurve(to: CGPoint(x: 0.62674*width, y: 0.42054*height), control1: CGPoint(x: 0.63438*width, y: 0.44008*height), control2: CGPoint(x: 0.62718*width, y: 0.42784*height))
                    path.addCurve(to: CGPoint(x: 0.6297*width, y: 0.40224*height), control1: CGPoint(x: 0.62602*width, y: 0.40921*height), control2: CGPoint(x: 0.6297*width, y: 0.40224*height))
                    path.closeSubpath()
                    return path
                        .scale(0.98).path(in: rect)
                        .offsetBy(dx: -0.0009*rect.size.width, dy: -0.004*rect.size.height)
                }
            }

            struct FlexorCarpiUlnaris: Shape {
                func path(in rect: CGRect) -> Path {
                    var path = Path()
                    let width = rect.size.width
                    let height = rect.size.height
                    path.move(to: CGPoint(x: 0.33644*width, y: 0.42184*height))
                    path.addCurve(to: CGPoint(x: 0.3138*width, y: 0.48224*height), control1: CGPoint(x: 0.32023*width, y: 0.46705*height), control2: CGPoint(x: 0.31567*width, y: 0.47542*height))
                    path.addCurve(to: CGPoint(x: 0.31148*width, y: 0.49187*height), control1: CGPoint(x: 0.31292*width, y: 0.48543*height), control2: CGPoint(x: 0.31234*width, y: 0.48867*height))
                    path.addCurve(to: CGPoint(x: 0.29956*width, y: 0.4925*height), control1: CGPoint(x: 0.30986*width, y: 0.49705*height), control2: CGPoint(x: 0.30065*width, y: 0.50029*height))
                    path.addCurve(to: CGPoint(x: 0.30079*width, y: 0.43694*height), control1: CGPoint(x: 0.29708*width, y: 0.47489*height), control2: CGPoint(x: 0.29891*width, y: 0.45435*height))
                    path.addLine(to: CGPoint(x: 0.30079*width, y: 0.43694*height))
                    path.addCurve(to: CGPoint(x: 0.32565*width, y: 0.39855*height), control1: CGPoint(x: 0.31479*width, y: 0.41573*height), control2: CGPoint(x: 0.32127*width, y: 0.4075*height))
                    path.move(to: CGPoint(x: 0.64875*width, y: 0.42184*height))
                    path.addCurve(to: CGPoint(x: 0.67141*width, y: 0.48224*height), control1: CGPoint(x: 0.66495*width, y: 0.46705*height), control2: CGPoint(x: 0.66951*width, y: 0.47542*height))
                    path.addCurve(to: CGPoint(x: 0.67387*width, y: 0.49187*height), control1: CGPoint(x: 0.67231*width, y: 0.48543*height), control2: CGPoint(x: 0.67289*width, y: 0.48867*height))
                    path.addCurve(to: CGPoint(x: 0.68579*width, y: 0.4925*height), control1: CGPoint(x: 0.67546*width, y: 0.49705*height), control2: CGPoint(x: 0.68468*width, y: 0.50029*height))
                    path.addCurve(to: CGPoint(x: 0.68454*width, y: 0.43694*height), control1: CGPoint(x: 0.68826*width, y: 0.47489*height), control2: CGPoint(x: 0.68641*width, y: 0.45435*height))
                    path.addLine(to: CGPoint(x: 0.68454*width, y: 0.43694*height))
                    path.addCurve(to: CGPoint(x: 0.65968*width, y: 0.39855*height), control1: CGPoint(x: 0.67056*width, y: 0.41573*height), control2: CGPoint(x: 0.66407*width, y: 0.4075*height))
                    return path
                        .scale(0.99).path(in: rect)
                        .offsetBy(dx: -0.0005*rect.size.width, dy: -0.0025*rect.size.height)
                }
            }
        }

        struct Glutes: Shape {
            func path(in rect: CGRect) -> Path {
                var path = Path()
                path.addPath(GluteusMaximus().path(in: rect))
                path.addPath(GluteusMedius().path(in: rect))
                return path
                    .offsetBy(dx: 0.008*rect.size.width, dy: -0.004*rect.size.height)
            }

            struct GluteusMaximus: Shape {
                func path(in rect: CGRect) -> Path {
                    var path = Path()
                    let width = rect.size.width
                    let height = rect.size.height
                    path.move(to: CGPoint(x: 0.49428*width, y: 0.52147*height))
                    path.addCurve(to: CGPoint(x: 0.52824*width, y: 0.53877*height), control1: CGPoint(x: 0.49769*width, y: 0.53154*height), control2: CGPoint(x: 0.5153*width, y: 0.53596*height))
                    path.addLine(to: CGPoint(x: 0.52838*width, y: 0.53878*height))
                    path.addCurve(to: CGPoint(x: 0.56609*width, y: 0.54722*height), control1: CGPoint(x: 0.54104*width, y: 0.54144*height), control2: CGPoint(x: 0.55343*width, y: 0.54457*height))
                    path.addCurve(to: CGPoint(x: 0.57111*width, y: 0.51998*height), control1: CGPoint(x: 0.59051*width, y: 0.55236*height), control2: CGPoint(x: 0.57458*width, y: 0.52685*height))
                    path.addCurve(to: CGPoint(x: 0.56634*width, y: 0.49702*height), control1: CGPoint(x: 0.56757*width, y: 0.51289*height), control2: CGPoint(x: 0.56426*width, y: 0.50457*height))
                    path.addCurve(to: CGPoint(x: 0.57144*width, y: 0.4871*height), control1: CGPoint(x: 0.56731*width, y: 0.49341*height), control2: CGPoint(x: 0.56889*width, y: 0.49032*height))
                    path.addCurve(to: CGPoint(x: 0.55238*width, y: 0.4738*height), control1: CGPoint(x: 0.57706*width, y: 0.47998*height), control2: CGPoint(x: 0.55836*width, y: 0.47594*height))
                    path.addCurve(to: CGPoint(x: 0.50583*width, y: 0.46983*height), control1: CGPoint(x: 0.53817*width, y: 0.46866*height), control2: CGPoint(x: 0.52019*width, y: 0.46074*height))
                    path.addCurve(to: CGPoint(x: 0.49734*width, y: 0.48005*height), control1: CGPoint(x: 0.50271*width, y: 0.47313*height), control2: CGPoint(x: 0.49984*width, y: 0.47651*height))
                    path.addLine(to: CGPoint(x: 0.49734*width, y: 0.48006*height))
                    path.addCurve(to: CGPoint(x: 0.494*width, y: 0.49111*height), control1: CGPoint(x: 0.49572*width, y: 0.48378*height), control2: CGPoint(x: 0.49484*width, y: 0.48767*height))
                    path.addCurve(to: CGPoint(x: 0.49428*width, y: 0.52147*height), control1: CGPoint(x: 0.49164*width, y: 0.5011*height), control2: CGPoint(x: 0.49097*width, y: 0.51156*height))
                    path.move(to: CGPoint(x: 0.4856*width, y: 0.52147*height))
                    path.addCurve(to: CGPoint(x: 0.45164*width, y: 0.53877*height), control1: CGPoint(x: 0.4822*width, y: 0.53154*height), control2: CGPoint(x: 0.46458*width, y: 0.53596*height))
                    path.addLine(to: CGPoint(x: 0.4515*width, y: 0.53878*height))
                    path.addCurve(to: CGPoint(x: 0.4138*width, y: 0.54722*height), control1: CGPoint(x: 0.43884*width, y: 0.54144*height), control2: CGPoint(x: 0.42646*width, y: 0.54457*height))
                    path.addCurve(to: CGPoint(x: 0.40877*width, y: 0.51998*height), control1: CGPoint(x: 0.38938*width, y: 0.55236*height), control2: CGPoint(x: 0.4053*width, y: 0.52685*height))
                    path.addCurve(to: CGPoint(x: 0.41354*width, y: 0.49702*height), control1: CGPoint(x: 0.41231*width, y: 0.51289*height), control2: CGPoint(x: 0.41563*width, y: 0.50457*height))
                    path.addCurve(to: CGPoint(x: 0.40845*width, y: 0.4871*height), control1: CGPoint(x: 0.41257*width, y: 0.49341*height), control2: CGPoint(x: 0.411*width, y: 0.49032*height))
                    path.addCurve(to: CGPoint(x: 0.4275*width, y: 0.4738*height), control1: CGPoint(x: 0.40282*width, y: 0.47998*height), control2: CGPoint(x: 0.42153*width, y: 0.47594*height))
                    path.addCurve(to: CGPoint(x: 0.47405*width, y: 0.46983*height), control1: CGPoint(x: 0.44171*width, y: 0.46866*height), control2: CGPoint(x: 0.4597*width, y: 0.46074*height))
                    path.addCurve(to: CGPoint(x: 0.48255*width, y: 0.48005*height), control1: CGPoint(x: 0.47718*width, y: 0.47313*height), control2: CGPoint(x: 0.48005*width, y: 0.47651*height))
                    path.addLine(to: CGPoint(x: 0.48255*width, y: 0.48006*height))
                    path.addCurve(to: CGPoint(x: 0.48588*width, y: 0.49111*height), control1: CGPoint(x: 0.48417*width, y: 0.48378*height), control2: CGPoint(x: 0.48505*width, y: 0.48767*height))
                    path.addCurve(to: CGPoint(x: 0.4856*width, y: 0.52147*height), control1: CGPoint(x: 0.48824*width, y: 0.5011*height), control2: CGPoint(x: 0.48891*width, y: 0.51156*height))
                    return path
                        .offsetBy(dx: 0.002*rect.size.width, dy: -0.0015*rect.size.height)
                }
            }

            struct GluteusMedius: Shape {
                func path(in rect: CGRect) -> Path {
                    var path = Path()
                    let width = rect.size.width
                    let height = rect.size.height
                    path.move(to: CGPoint(x: 0.47627*width, y: 0.46718*height))
                    path.addCurve(to: CGPoint(x: 0.44646*width, y: 0.46582*height), control1: CGPoint(x: 0.46956*width, y: 0.46319*height), control2: CGPoint(x: 0.46007*width, y: 0.46201*height))
                    path.addCurve(to: CGPoint(x: 0.42183*width, y: 0.47457*height), control1: CGPoint(x: 0.43796*width, y: 0.46821*height), control2: CGPoint(x: 0.42991*width, y: 0.47162*height))
                    path.addCurve(to: CGPoint(x: 0.40808*width, y: 0.48103*height), control1: CGPoint(x: 0.41972*width, y: 0.47532*height), control2: CGPoint(x: 0.40813*width, y: 0.47804*height))
                    path.addLine(to: CGPoint(x: 0.40808*width, y: 0.48105*height))
                    path.addCurve(to: CGPoint(x: 0.39296*width, y: 0.48981*height), control1: CGPoint(x: 0.40234*width, y: 0.48341*height), control2: CGPoint(x: 0.39729*width, y: 0.48636*height))
                    path.addCurve(to: CGPoint(x: 0.39299*width, y: 0.48674*height), control1: CGPoint(x: 0.39308*width, y: 0.4887*height), control2: CGPoint(x: 0.39308*width, y: 0.4877*height))
                    path.addCurve(to: CGPoint(x: 0.40169*width, y: 0.44883*height), control1: CGPoint(x: 0.39169*width, y: 0.47344*height), control2: CGPoint(x: 0.39873*width, y: 0.45565*height))
                    path.addCurve(to: CGPoint(x: 0.45546*width, y: 0.44883*height), control1: CGPoint(x: 0.41961*width, y: 0.44005*height), control2: CGPoint(x: 0.43859*width, y: 0.43534*height))
                    path.addCurve(to: CGPoint(x: 0.47627*width, y: 0.46718*height), control1: CGPoint(x: 0.46285*width, y: 0.45475*height), control2: CGPoint(x: 0.47005*width, y: 0.46076*height))
                    path.move(to: CGPoint(x: 0.5106*width, y: 0.46718*height))
                    path.addCurve(to: CGPoint(x: 0.54042*width, y: 0.46582*height), control1: CGPoint(x: 0.51731*width, y: 0.46319*height), control2: CGPoint(x: 0.52681*width, y: 0.46201*height))
                    path.addCurve(to: CGPoint(x: 0.56505*width, y: 0.47457*height), control1: CGPoint(x: 0.54891*width, y: 0.46821*height), control2: CGPoint(x: 0.55697*width, y: 0.47162*height))
                    path.addCurve(to: CGPoint(x: 0.5788*width, y: 0.48103*height), control1: CGPoint(x: 0.56715*width, y: 0.47532*height), control2: CGPoint(x: 0.57875*width, y: 0.47804*height))
                    path.addLine(to: CGPoint(x: 0.5788*width, y: 0.48105*height))
                    path.addCurve(to: CGPoint(x: 0.59391*width, y: 0.48981*height), control1: CGPoint(x: 0.58454*width, y: 0.48341*height), control2: CGPoint(x: 0.58958*width, y: 0.48636*height))
                    path.addCurve(to: CGPoint(x: 0.59389*width, y: 0.48674*height), control1: CGPoint(x: 0.5938*width, y: 0.4887*height), control2: CGPoint(x: 0.5938*width, y: 0.4877*height))
                    path.addCurve(to: CGPoint(x: 0.58519*width, y: 0.44883*height), control1: CGPoint(x: 0.59519*width, y: 0.47344*height), control2: CGPoint(x: 0.58815*width, y: 0.45565*height))
                    path.addCurve(to: CGPoint(x: 0.53141*width, y: 0.44883*height), control1: CGPoint(x: 0.56727*width, y: 0.44005*height), control2: CGPoint(x: 0.54829*width, y: 0.43534*height))
                    path.addCurve(to: CGPoint(x: 0.5106*width, y: 0.46718*height), control1: CGPoint(x: 0.52403*width, y: 0.45475*height), control2: CGPoint(x: 0.51683*width, y: 0.46076*height))
                    return path
                        .offsetBy(dx: -0.0015*rect.size.width, dy: -0.0005*rect.size.height)
                }
            }
        }

        struct Hamstrings: Shape {
            func path(in rect: CGRect) -> Path {
                var path = Path()
                path.addPath(BicepsFermoris().path(in: rect))
                path.addPath(Gracilis().path(in: rect))
                path.addPath(Semitendinosus().path(in: rect))
                return path
                    .offsetBy(dx: 0.0075*rect.size.width, dy: -0.004*rect.size.height)
            }

            struct BicepsFermoris: Shape {
                func path(in rect: CGRect) -> Path {
                    var path = Path()
                    let width = rect.size.width
                    let height = rect.size.height
                    path.move(to: CGPoint(x: 0.55299*width, y: 0.56941*height))
                    path.addCurve(to: CGPoint(x: 0.56194*width, y: 0.61052*height), control1: CGPoint(x: 0.55454*width, y: 0.58323*height), control2: CGPoint(x: 0.55787*width, y: 0.59696*height))
                    path.addCurve(to: CGPoint(x: 0.59699*width, y: 0.67648*height), control1: CGPoint(x: 0.56882*width, y: 0.63343*height), control2: CGPoint(x: 0.58289*width, y: 0.65505*height))
                    path.addLine(to: CGPoint(x: 0.59725*width, y: 0.67685*height))
                    path.addCurve(to: CGPoint(x: 0.60164*width, y: 0.6836*height), control1: CGPoint(x: 0.59877*width, y: 0.67904*height), control2: CGPoint(x: 0.60025*width, y: 0.68131*height))
                    path.addCurve(to: CGPoint(x: 0.6031*width, y: 0.6858*height), control1: CGPoint(x: 0.60215*width, y: 0.68434*height), control2: CGPoint(x: 0.60262*width, y: 0.68508*height))
                    path.addCurve(to: CGPoint(x: 0.60326*width, y: 0.68497*height), control1: CGPoint(x: 0.60317*width, y: 0.68551*height), control2: CGPoint(x: 0.60324*width, y: 0.68525*height))
                    path.addCurve(to: CGPoint(x: 0.60285*width, y: 0.67622*height), control1: CGPoint(x: 0.60373*width, y: 0.68059*height), control2: CGPoint(x: 0.60326*width, y: 0.67827*height))
                    path.addCurve(to: CGPoint(x: 0.60243*width, y: 0.671*height), control1: CGPoint(x: 0.60252*width, y: 0.67465*height), control2: CGPoint(x: 0.60225*width, y: 0.67313*height))
                    path.addCurve(to: CGPoint(x: 0.6038*width, y: 0.66349*height), control1: CGPoint(x: 0.6025*width, y: 0.67015*height), control2: CGPoint(x: 0.60301*width, y: 0.6675*height))
                    path.addCurve(to: CGPoint(x: 0.61046*width, y: 0.62451*height), control1: CGPoint(x: 0.60537*width, y: 0.65515*height), control2: CGPoint(x: 0.60817*width, y: 0.64066*height))
                    path.addLine(to: CGPoint(x: 0.61046*width, y: 0.62449*height))
                    path.addCurve(to: CGPoint(x: 0.584*width, y: 0.54403*height), control1: CGPoint(x: 0.60461*width, y: 0.5971*height), control2: CGPoint(x: 0.60014*width, y: 0.56983*height))
                    path.addCurve(to: CGPoint(x: 0.58*width, y: 0.54806*height), control1: CGPoint(x: 0.58363*width, y: 0.54596*height), control2: CGPoint(x: 0.58243*width, y: 0.54744*height))
                    path.addCurve(to: CGPoint(x: 0.56567*width, y: 0.54772*height), control1: CGPoint(x: 0.57512*width, y: 0.54929*height), control2: CGPoint(x: 0.57053*width, y: 0.54877*height))
                    path.addCurve(to: CGPoint(x: 0.55308*width, y: 0.54492*height), control1: CGPoint(x: 0.56146*width, y: 0.54684*height), control2: CGPoint(x: 0.55727*width, y: 0.5459*height))
                    path.addCurve(to: CGPoint(x: 0.55299*width, y: 0.56941*height), control1: CGPoint(x: 0.55049*width, y: 0.55278*height), control2: CGPoint(x: 0.55218*width, y: 0.5619*height))
                    path.move(to: CGPoint(x: 0.43157*width, y: 0.56901*height))
                    path.addCurve(to: CGPoint(x: 0.42262*width, y: 0.61012*height), control1: CGPoint(x: 0.43002*width, y: 0.58282*height), control2: CGPoint(x: 0.42669*width, y: 0.59656*height))
                    path.addCurve(to: CGPoint(x: 0.38757*width, y: 0.67608*height), control1: CGPoint(x: 0.41574*width, y: 0.63302*height), control2: CGPoint(x: 0.40167*width, y: 0.65465*height))
                    path.addLine(to: CGPoint(x: 0.38731*width, y: 0.67645*height))
                    path.addCurve(to: CGPoint(x: 0.38292*width, y: 0.68319*height), control1: CGPoint(x: 0.38579*width, y: 0.67864*height), control2: CGPoint(x: 0.38431*width, y: 0.68091*height))
                    path.addCurve(to: CGPoint(x: 0.38146*width, y: 0.6854*height), control1: CGPoint(x: 0.38241*width, y: 0.68394*height), control2: CGPoint(x: 0.38194*width, y: 0.68468*height))
                    path.addCurve(to: CGPoint(x: 0.3813*width, y: 0.68457*height), control1: CGPoint(x: 0.38139*width, y: 0.68511*height), control2: CGPoint(x: 0.38132*width, y: 0.68485*height))
                    path.addCurve(to: CGPoint(x: 0.38171*width, y: 0.67582*height), control1: CGPoint(x: 0.38083*width, y: 0.68019*height), control2: CGPoint(x: 0.3813*width, y: 0.67787*height))
                    path.addCurve(to: CGPoint(x: 0.38213*width, y: 0.6706*height), control1: CGPoint(x: 0.38204*width, y: 0.67424*height), control2: CGPoint(x: 0.38231*width, y: 0.67273*height))
                    path.addCurve(to: CGPoint(x: 0.38076*width, y: 0.66309*height), control1: CGPoint(x: 0.38206*width, y: 0.66975*height), control2: CGPoint(x: 0.38155*width, y: 0.6671*height))
                    path.addCurve(to: CGPoint(x: 0.3741*width, y: 0.6241*height), control1: CGPoint(x: 0.37919*width, y: 0.65475*height), control2: CGPoint(x: 0.37639*width, y: 0.64026*height))
                    path.addLine(to: CGPoint(x: 0.3741*width, y: 0.62409*height))
                    path.addCurve(to: CGPoint(x: 0.40056*width, y: 0.54363*height), control1: CGPoint(x: 0.37995*width, y: 0.5967*height), control2: CGPoint(x: 0.38442*width, y: 0.56943*height))
                    path.addCurve(to: CGPoint(x: 0.40456*width, y: 0.54765*height), control1: CGPoint(x: 0.40093*width, y: 0.54556*height), control2: CGPoint(x: 0.40213*width, y: 0.54704*height))
                    path.addCurve(to: CGPoint(x: 0.41889*width, y: 0.54731*height), control1: CGPoint(x: 0.40944*width, y: 0.54889*height), control2: CGPoint(x: 0.41403*width, y: 0.54836*height))
                    path.addCurve(to: CGPoint(x: 0.43148*width, y: 0.54452*height), control1: CGPoint(x: 0.4231*width, y: 0.54644*height), control2: CGPoint(x: 0.42729*width, y: 0.54549*height))
                    path.addCurve(to: CGPoint(x: 0.43157*width, y: 0.56901*height), control1: CGPoint(x: 0.43407*width, y: 0.55239*height), control2: CGPoint(x: 0.43238*width, y: 0.56151*height))
                    return path
                        .scale(0.99).path(in: rect)
                        .offsetBy(dx: 0.000*rect.size.width, dy: -0.001*rect.size.height)
                }
            }

            struct Gracilis: Shape {
                func path(in rect: CGRect) -> Path {
                    var path = Path()
                    let width = rect.size.width
                    let height = rect.size.height
                    path.move(to: CGPoint(x: 0.4659*width, y: 0.62461*height))
                    path.addCurve(to: CGPoint(x: 0.46488*width, y: 0.63262*height), control1: CGPoint(x: 0.46553*width, y: 0.62733*height), control2: CGPoint(x: 0.46519*width, y: 0.63003*height))
                    path.addCurve(to: CGPoint(x: 0.46028*width, y: 0.66221*height), control1: CGPoint(x: 0.46333*width, y: 0.64488*height), control2: CGPoint(x: 0.46187*width, y: 0.65644*height))
                    path.addCurve(to: CGPoint(x: 0.45294*width, y: 0.6763*height), control1: CGPoint(x: 0.45928*width, y: 0.6659*height), control2: CGPoint(x: 0.4566*width, y: 0.67094*height))
                    path.addCurve(to: CGPoint(x: 0.45593*width, y: 0.59122*height), control1: CGPoint(x: 0.45979*width, y: 0.6483*height), control2: CGPoint(x: 0.44185*width, y: 0.61815*height))
                    path.addCurve(to: CGPoint(x: 0.4659*width, y: 0.62461*height), control1: CGPoint(x: 0.45863*width, y: 0.60236*height), control2: CGPoint(x: 0.4625*width, y: 0.6135*height))
                    path.move(to: CGPoint(x: 0.51576*width, y: 0.62461*height))
                    path.addCurve(to: CGPoint(x: 0.51678*width, y: 0.63262*height), control1: CGPoint(x: 0.51613*width, y: 0.62733*height), control2: CGPoint(x: 0.51648*width, y: 0.63003*height))
                    path.addCurve(to: CGPoint(x: 0.52139*width, y: 0.66221*height), control1: CGPoint(x: 0.51833*width, y: 0.64488*height), control2: CGPoint(x: 0.51979*width, y: 0.65644*height))
                    path.addCurve(to: CGPoint(x: 0.52873*width, y: 0.6763*height), control1: CGPoint(x: 0.52238*width, y: 0.6659*height), control2: CGPoint(x: 0.52507*width, y: 0.67094*height))
                    path.addCurve(to: CGPoint(x: 0.52574*width, y: 0.59122*height), control1: CGPoint(x: 0.52187*width, y: 0.6483*height), control2: CGPoint(x: 0.53981*width, y: 0.61815*height))
                    path.addCurve(to: CGPoint(x: 0.51576*width, y: 0.62461*height), control1: CGPoint(x: 0.52303*width, y: 0.60236*height), control2: CGPoint(x: 0.51917*width, y: 0.6135*height))
                    return path
                        .scale(0.99).path(in: rect)
                        .offsetBy(dx: 0.002*rect.size.width, dy: 0.000*rect.size.height)
                }
            }

            struct Semitendinosus: Shape {
                func path(in rect: CGRect) -> Path {
                    var path = Path()
                    let width = rect.size.width
                    let height = rect.size.height
                    path.move(to: CGPoint(x: 0.53153*width, y: 0.59048*height))
                    path.addCurve(to: CGPoint(x: 0.53644*width, y: 0.68105*height), control1: CGPoint(x: 0.54785*width, y: 0.61915*height), control2: CGPoint(x: 0.52657*width, y: 0.65145*height))
                    path.addCurve(to: CGPoint(x: 0.54646*width, y: 0.69309*height), control1: CGPoint(x: 0.53942*width, y: 0.68515*height), control2: CGPoint(x: 0.54285*width, y: 0.68931*height))
                    path.addCurve(to: CGPoint(x: 0.55053*width, y: 0.68269*height), control1: CGPoint(x: 0.54873*width, y: 0.68731*height), control2: CGPoint(x: 0.55053*width, y: 0.68269*height))
                    path.addLine(to: CGPoint(x: 0.55069*width, y: 0.68239*height))
                    path.addCurve(to: CGPoint(x: 0.57303*width, y: 0.63071*height), control1: CGPoint(x: 0.55965*width, y: 0.66409*height), control2: CGPoint(x: 0.5759*width, y: 0.64866*height))
                    path.addLine(to: CGPoint(x: 0.57303*width, y: 0.63069*height))
                    path.addLine(to: CGPoint(x: 0.57301*width, y: 0.63066*height))
                    path.addCurve(to: CGPoint(x: 0.56282*width, y: 0.60443*height), control1: CGPoint(x: 0.56887*width, y: 0.6221*height), control2: CGPoint(x: 0.56537*width, y: 0.61336*height))
                    path.addCurve(to: CGPoint(x: 0.55507*width, y: 0.56485*height), control1: CGPoint(x: 0.55912*width, y: 0.59137*height), control2: CGPoint(x: 0.55639*width, y: 0.57813*height))
                    path.addCurve(to: CGPoint(x: 0.55565*width, y: 0.54375*height), control1: CGPoint(x: 0.55444*width, y: 0.55827*height), control2: CGPoint(x: 0.55345*width, y: 0.55057*height))
                    path.addCurve(to: CGPoint(x: 0.5341*width, y: 0.53889*height), control1: CGPoint(x: 0.5485*width, y: 0.54211*height), control2: CGPoint(x: 0.54134*width, y: 0.5404*height))
                    path.addCurve(to: CGPoint(x: 0.52741*width, y: 0.53738*height), control1: CGPoint(x: 0.53185*width, y: 0.53841*height), control2: CGPoint(x: 0.52961*width, y: 0.5379*height))
                    path.addCurve(to: CGPoint(x: 0.53153*width, y: 0.59048*height), control1: CGPoint(x: 0.53655*width, y: 0.55492*height), control2: CGPoint(x: 0.53565*width, y: 0.57269*height))
                    path.move(to: CGPoint(x: 0.46069*width, y: 0.59048*height))
                    path.addCurve(to: CGPoint(x: 0.45579*width, y: 0.68105*height), control1: CGPoint(x: 0.44438*width, y: 0.61915*height), control2: CGPoint(x: 0.46565*width, y: 0.65145*height))
                    path.addCurve(to: CGPoint(x: 0.44576*width, y: 0.69309*height), control1: CGPoint(x: 0.4528*width, y: 0.68515*height), control2: CGPoint(x: 0.44937*width, y: 0.68931*height))
                    path.addCurve(to: CGPoint(x: 0.44169*width, y: 0.68269*height), control1: CGPoint(x: 0.4435*width, y: 0.68731*height), control2: CGPoint(x: 0.44169*width, y: 0.68269*height))
                    path.addLine(to: CGPoint(x: 0.44153*width, y: 0.68239*height))
                    path.addCurve(to: CGPoint(x: 0.41919*width, y: 0.63071*height), control1: CGPoint(x: 0.43257*width, y: 0.66409*height), control2: CGPoint(x: 0.41632*width, y: 0.64866*height))
                    path.addLine(to: CGPoint(x: 0.41919*width, y: 0.63069*height))
                    path.addLine(to: CGPoint(x: 0.41921*width, y: 0.63066*height))
                    path.addCurve(to: CGPoint(x: 0.4294*width, y: 0.60443*height), control1: CGPoint(x: 0.42336*width, y: 0.6221*height), control2: CGPoint(x: 0.42685*width, y: 0.61336*height))
                    path.addCurve(to: CGPoint(x: 0.43715*width, y: 0.56485*height), control1: CGPoint(x: 0.4331*width, y: 0.59137*height), control2: CGPoint(x: 0.43583*width, y: 0.57813*height))
                    path.addCurve(to: CGPoint(x: 0.43657*width, y: 0.54375*height), control1: CGPoint(x: 0.43778*width, y: 0.55827*height), control2: CGPoint(x: 0.43877*width, y: 0.55057*height))
                    path.addCurve(to: CGPoint(x: 0.45813*width, y: 0.53889*height), control1: CGPoint(x: 0.44373*width, y: 0.54211*height), control2: CGPoint(x: 0.45088*width, y: 0.5404*height))
                    path.addCurve(to: CGPoint(x: 0.46481*width, y: 0.53738*height), control1: CGPoint(x: 0.46037*width, y: 0.53841*height), control2: CGPoint(x: 0.46262*width, y: 0.5379*height))
                    path.addCurve(to: CGPoint(x: 0.46069*width, y: 0.59048*height), control1: CGPoint(x: 0.45567*width, y: 0.55492*height), control2: CGPoint(x: 0.45657*width, y: 0.57269*height))
                    return path
                        .scale(0.975).path(in: rect)
                        .offsetBy(dx: -0.00325*rect.size.width, dy: 0.000*rect.size.height)
                }
            }
        }

        struct Laterals: Shape {
            func path(in rect: CGRect) -> Path {
                var path = Path()
                path.addPath(LatissimusDorsi().path(in: rect))
                path.addPath(RhomboidMajor().path(in: rect))
                path.addPath(TeresMajor().path(in: rect))
                return path
                    .offsetBy(dx: 0.008*rect.size.width, dy: -0.004*rect.size.height)
            }

            struct LatissimusDorsi: Shape {
                func path(in rect: CGRect) -> Path {
                    var path = Path()
                    let width = rect.size.width
                    let height = rect.size.height
                    path.move(to: CGPoint(x: 0.50065*width, y: 0.36512*height))
                    path.addCurve(to: CGPoint(x: 0.51072*width, y: 0.40323*height), control1: CGPoint(x: 0.50194*width, y: 0.37795*height), control2: CGPoint(x: 0.50597*width, y: 0.39082*height))
                    path.addCurve(to: CGPoint(x: 0.51738*width, y: 0.41898*height), control1: CGPoint(x: 0.51275*width, y: 0.40852*height), control2: CGPoint(x: 0.51523*width, y: 0.41372*height))
                    path.addCurve(to: CGPoint(x: 0.52539*width, y: 0.42952*height), control1: CGPoint(x: 0.51891*width, y: 0.42265*height), control2: CGPoint(x: 0.52058*width, y: 0.42707*height))
                    path.addCurve(to: CGPoint(x: 0.53669*width, y: 0.42265*height), control1: CGPoint(x: 0.53245*width, y: 0.43315*height), control2: CGPoint(x: 0.53574*width, y: 0.42627*height))
                    path.addCurve(to: CGPoint(x: 0.55505*width, y: 0.39176*height), control1: CGPoint(x: 0.53947*width, y: 0.41218*height), control2: CGPoint(x: 0.54812*width, y: 0.4013*height))
                    path.addCurve(to: CGPoint(x: 0.57609*width, y: 0.36341*height), control1: CGPoint(x: 0.5619*width, y: 0.3823*height), control2: CGPoint(x: 0.5688*width, y: 0.37278*height))
                    path.addLine(to: CGPoint(x: 0.57627*width, y: 0.36315*height))
                    path.addCurve(to: CGPoint(x: 0.58049*width, y: 0.35531*height), control1: CGPoint(x: 0.57752*width, y: 0.36079*height), control2: CGPoint(x: 0.57889*width, y: 0.35813*height))
                    path.addCurve(to: CGPoint(x: 0.58641*width, y: 0.34451*height), control1: CGPoint(x: 0.58257*width, y: 0.35165*height), control2: CGPoint(x: 0.58472*width, y: 0.34787*height))
                    path.addCurve(to: CGPoint(x: 0.5975*width, y: 0.31122*height), control1: CGPoint(x: 0.58863*width, y: 0.34008*height), control2: CGPoint(x: 0.5935*width, y: 0.32461*height))
                    path.addCurve(to: CGPoint(x: 0.55058*width, y: 0.31275*height), control1: CGPoint(x: 0.58801*width, y: 0.31846*height), control2: CGPoint(x: 0.56178*width, y: 0.31519*height))
                    path.addCurve(to: CGPoint(x: 0.54141*width, y: 0.32648*height), control1: CGPoint(x: 0.54854*width, y: 0.31735*height), control2: CGPoint(x: 0.54544*width, y: 0.32188*height))
                    path.addCurve(to: CGPoint(x: 0.50301*width, y: 0.36356*height), control1: CGPoint(x: 0.53023*width, y: 0.33926*height), control2: CGPoint(x: 0.5169*width, y: 0.35205*height))
                    path.addCurve(to: CGPoint(x: 0.50065*width, y: 0.36512*height), control1: CGPoint(x: 0.50218*width, y: 0.36429*height), control2: CGPoint(x: 0.50139*width, y: 0.3648*height))
                    path.move(to: CGPoint(x: 0.48345*width, y: 0.36514*height))
                    path.addCurve(to: CGPoint(x: 0.47338*width, y: 0.40324*height), control1: CGPoint(x: 0.48215*width, y: 0.37796*height), control2: CGPoint(x: 0.47812*width, y: 0.39083*height))
                    path.addCurve(to: CGPoint(x: 0.46671*width, y: 0.419*height), control1: CGPoint(x: 0.47134*width, y: 0.40853*height), control2: CGPoint(x: 0.46887*width, y: 0.41373*height))
                    path.addCurve(to: CGPoint(x: 0.4587*width, y: 0.42954*height), control1: CGPoint(x: 0.46519*width, y: 0.42267*height), control2: CGPoint(x: 0.46352*width, y: 0.42708*height))
                    path.addCurve(to: CGPoint(x: 0.44741*width, y: 0.42267*height), control1: CGPoint(x: 0.45164*width, y: 0.43316*height), control2: CGPoint(x: 0.44836*width, y: 0.42628*height))
                    path.addCurve(to: CGPoint(x: 0.42905*width, y: 0.39177*height), control1: CGPoint(x: 0.44463*width, y: 0.41219*height), control2: CGPoint(x: 0.43597*width, y: 0.40131*height))
                    path.addCurve(to: CGPoint(x: 0.40801*width, y: 0.36343*height), control1: CGPoint(x: 0.4222*width, y: 0.38231*height), control2: CGPoint(x: 0.4153*width, y: 0.37279*height))
                    path.addLine(to: CGPoint(x: 0.40782*width, y: 0.36316*height))
                    path.addCurve(to: CGPoint(x: 0.40361*width, y: 0.35532*height), control1: CGPoint(x: 0.40657*width, y: 0.3608*height), control2: CGPoint(x: 0.40521*width, y: 0.35815*height))
                    path.addCurve(to: CGPoint(x: 0.39769*width, y: 0.34452*height), control1: CGPoint(x: 0.40153*width, y: 0.35167*height), control2: CGPoint(x: 0.39937*width, y: 0.34789*height))
                    path.addCurve(to: CGPoint(x: 0.3866*width, y: 0.31123*height), control1: CGPoint(x: 0.39546*width, y: 0.34009*height), control2: CGPoint(x: 0.3906*width, y: 0.32463*height))
                    path.addCurve(to: CGPoint(x: 0.43352*width, y: 0.31276*height), control1: CGPoint(x: 0.39609*width, y: 0.31847*height), control2: CGPoint(x: 0.42231*width, y: 0.3152*height))
                    path.addCurve(to: CGPoint(x: 0.44269*width, y: 0.3265*height), control1: CGPoint(x: 0.43556*width, y: 0.31736*height), control2: CGPoint(x: 0.43866*width, y: 0.3219*height))
                    path.addCurve(to: CGPoint(x: 0.48109*width, y: 0.36358*height), control1: CGPoint(x: 0.45387*width, y: 0.33927*height), control2: CGPoint(x: 0.4672*width, y: 0.35207*height))
                    path.addCurve(to: CGPoint(x: 0.48345*width, y: 0.36514*height), control1: CGPoint(x: 0.48192*width, y: 0.36431*height), control2: CGPoint(x: 0.48271*width, y: 0.36481*height))
                    return path
                }
            }

            struct RhomboidMajor: Shape {
                func path(in rect: CGRect) -> Path {
                    var path = Path()
                    let width = rect.size.width
                    let height = rect.size.height
                    path.move(to: CGPoint(x: 0.54995*width, y: 0.31167*height))
                    path.addCurve(to: CGPoint(x: 0.56683*width, y: 0.3141*height), control1: CGPoint(x: 0.554*width, y: 0.31255*height), control2: CGPoint(x: 0.56021*width, y: 0.31355*height))
                    path.addCurve(to: CGPoint(x: 0.55188*width, y: 0.29648*height), control1: CGPoint(x: 0.56273*width, y: 0.30789*height), control2: CGPoint(x: 0.55775*width, y: 0.30202*height))
                    path.addCurve(to: CGPoint(x: 0.54995*width, y: 0.31167*height), control1: CGPoint(x: 0.55264*width, y: 0.30176*height), control2: CGPoint(x: 0.55192*width, y: 0.30677*height))
                    path.move(to: CGPoint(x: 0.43257*width, y: 0.31167*height))
                    path.addCurve(to: CGPoint(x: 0.41569*width, y: 0.3141*height), control1: CGPoint(x: 0.42852*width, y: 0.31255*height), control2: CGPoint(x: 0.42231*width, y: 0.31355*height))
                    path.addCurve(to: CGPoint(x: 0.43065*width, y: 0.29648*height), control1: CGPoint(x: 0.41979*width, y: 0.30789*height), control2: CGPoint(x: 0.42477*width, y: 0.30202*height))
                    path.addCurve(to: CGPoint(x: 0.43257*width, y: 0.31167*height), control1: CGPoint(x: 0.42991*width, y: 0.30176*height), control2: CGPoint(x: 0.4306*width, y: 0.30677*height))
                    return path
                        .offsetBy(dx: 0.0005*rect.size.width, dy: 0.0005*rect.size.height)
                }
            }

            struct TeresMajor: Shape {
                func path(in rect: CGRect) -> Path {
                    var path = Path()
                    let width = rect.size.width
                    let height = rect.size.height
                    path.move(to: CGPoint(x: 0.56169*width, y: 0.30154*height))
                    path.addCurve(to: CGPoint(x: 0.57262*width, y: 0.3154*height), control1: CGPoint(x: 0.56586*width, y: 0.30594*height), control2: CGPoint(x: 0.56947*width, y: 0.31057*height))
                    path.addLine(to: CGPoint(x: 0.57269*width, y: 0.31554*height))
                    path.addCurve(to: CGPoint(x: 0.60132*width, y: 0.30937*height), control1: CGPoint(x: 0.58468*width, y: 0.31636*height), control2: CGPoint(x: 0.5975*width, y: 0.31539*height))
                    path.addLine(to: CGPoint(x: 0.60134*width, y: 0.30927*height))
                    path.addCurve(to: CGPoint(x: 0.60637*width, y: 0.29198*height), control1: CGPoint(x: 0.60366*width, y: 0.30148*height), control2: CGPoint(x: 0.60558*width, y: 0.2948*height))
                    path.addCurve(to: CGPoint(x: 0.59734*width, y: 0.28596*height), control1: CGPoint(x: 0.60271*width, y: 0.29043*height), control2: CGPoint(x: 0.59951*width, y: 0.28852*height))
                    path.addCurve(to: CGPoint(x: 0.56169*width, y: 0.30154*height), control1: CGPoint(x: 0.58794*width, y: 0.29346*height), control2: CGPoint(x: 0.57551*width, y: 0.2984*height))
                    path.move(to: CGPoint(x: 0.42845*width, y: 0.30154*height))
                    path.addCurve(to: CGPoint(x: 0.41752*width, y: 0.3154*height), control1: CGPoint(x: 0.42428*width, y: 0.30594*height), control2: CGPoint(x: 0.42067*width, y: 0.31057*height))
                    path.addLine(to: CGPoint(x: 0.41745*width, y: 0.31554*height))
                    path.addCurve(to: CGPoint(x: 0.38882*width, y: 0.30937*height), control1: CGPoint(x: 0.40546*width, y: 0.31636*height), control2: CGPoint(x: 0.39264*width, y: 0.31539*height))
                    path.addLine(to: CGPoint(x: 0.3888*width, y: 0.30927*height))
                    path.addCurve(to: CGPoint(x: 0.38377*width, y: 0.29198*height), control1: CGPoint(x: 0.38648*width, y: 0.30148*height), control2: CGPoint(x: 0.38456*width, y: 0.2948*height))
                    path.addCurve(to: CGPoint(x: 0.3928*width, y: 0.28596*height), control1: CGPoint(x: 0.38743*width, y: 0.29043*height), control2: CGPoint(x: 0.39063*width, y: 0.28852*height))
                    path.addCurve(to: CGPoint(x: 0.42845*width, y: 0.30154*height), control1: CGPoint(x: 0.4022*width, y: 0.29346*height), control2: CGPoint(x: 0.41463*width, y: 0.2984*height))
                    return path
                        .offsetBy(dx: -0.00325*rect.size.width, dy: -0.0005*rect.size.height)
                }
            }
        }

        struct Lumbars: Shape {
            func path(in rect: CGRect) -> Path {
                var path = Path()
                path.addPath(ThoracolumbarFascia().path(in: rect))
                return path
                    .offsetBy(dx: 0.0095*rect.size.width, dy: -0.004*rect.size.height)
            }

            struct ThoracolumbarFascia: Shape {
                func path(in rect: CGRect) -> Path {
                    var path = Path()
                    let width = rect.size.width
                    let height = rect.size.height
                    path.move(to: CGPoint(x: 0.52461*width, y: 0.43147*height))
                    path.addCurve(to: CGPoint(x: 0.52833*width, y: 0.44215*height), control1: CGPoint(x: 0.53067*width, y: 0.43465*height), control2: CGPoint(x: 0.52891*width, y: 0.44049*height))
                    path.addCurve(to: CGPoint(x: 0.49218*width, y: 0.47386*height), control1: CGPoint(x: 0.52706*width, y: 0.44569*height), control2: CGPoint(x: 0.50116*width, y: 0.46802*height))
                    path.addCurve(to: CGPoint(x: 0.48838*width, y: 0.47336*height), control1: CGPoint(x: 0.49148*width, y: 0.47432*height), control2: CGPoint(x: 0.4891*width, y: 0.4738*height))
                    path.addCurve(to: CGPoint(x: 0.45141*width, y: 0.44199*height), control1: CGPoint(x: 0.4787*width, y: 0.46739*height), control2: CGPoint(x: 0.45269*width, y: 0.44554*height))
                    path.addCurve(to: CGPoint(x: 0.45681*width, y: 0.43159*height), control1: CGPoint(x: 0.45081*width, y: 0.44034*height), control2: CGPoint(x: 0.45063*width, y: 0.4348*height))
                    path.addCurve(to: CGPoint(x: 0.46935*width, y: 0.41256*height), control1: CGPoint(x: 0.46558*width, y: 0.4288*height), control2: CGPoint(x: 0.46741*width, y: 0.41705*height))
                    path.addCurve(to: CGPoint(x: 0.48106*width, y: 0.3769*height), control1: CGPoint(x: 0.47447*width, y: 0.40082*height), control2: CGPoint(x: 0.47852*width, y: 0.3891*height))
                    path.addCurve(to: CGPoint(x: 0.48868*width, y: 0.36883*height), control1: CGPoint(x: 0.48306*width, y: 0.37417*height), control2: CGPoint(x: 0.48671*width, y: 0.37054*height))
                    path.addCurve(to: CGPoint(x: 0.49275*width, y: 0.36901*height), control1: CGPoint(x: 0.49007*width, y: 0.36761*height), control2: CGPoint(x: 0.49148*width, y: 0.36779*height))
                    path.addCurve(to: CGPoint(x: 0.49981*width, y: 0.37721*height), control1: CGPoint(x: 0.49444*width, y: 0.37062*height), control2: CGPoint(x: 0.49785*width, y: 0.3744*height))
                    path.addCurve(to: CGPoint(x: 0.51183*width, y: 0.41259*height), control1: CGPoint(x: 0.50238*width, y: 0.38918*height), control2: CGPoint(x: 0.50681*width, y: 0.40105*height))
                    path.addCurve(to: CGPoint(x: 0.52461*width, y: 0.43147*height), control1: CGPoint(x: 0.51377*width, y: 0.41699*height), control2: CGPoint(x: 0.51609*width, y: 0.42849*height))
                    path.closeSubpath()
                    return path
                }
            }
        }

        struct Obliques: Shape {
            func path(in rect: CGRect) -> Path {
                var path = Path()
                path.addPath(ExternalObliques().path(in: rect))
                path.addPath(SerratusAnterior().path(in: rect))
                return path
                    .offsetBy(dx: 0.008*rect.size.width, dy: -0.0075*rect.size.height)
            }

            struct ExternalObliques: Shape {
                func path(in rect: CGRect) -> Path {
                    var path = Path()
                    let width = rect.size.width
                    let height = rect.size.height
                    path.move(to: CGPoint(x: 0.58354*width, y: 0.45011*height))
                    path.addCurve(to: CGPoint(x: 0.57433*width, y: 0.41221*height), control1: CGPoint(x: 0.58354*width, y: 0.45011*height), control2: CGPoint(x: 0.59847*width, y: 0.43262*height))
                    path.addCurve(to: CGPoint(x: 0.53912*width, y: 0.43319*height), control1: CGPoint(x: 0.56979*width, y: 0.42043*height), control2: CGPoint(x: 0.55028*width, y: 0.43059*height))
                    path.addCurve(to: CGPoint(x: 0.55799*width, y: 0.43954*height), control1: CGPoint(x: 0.54563*width, y: 0.43562*height), control2: CGPoint(x: 0.55301*width, y: 0.43832*height))
                    path.addCurve(to: CGPoint(x: 0.58354*width, y: 0.45011*height), control1: CGPoint(x: 0.5666*width, y: 0.44167*height), control2: CGPoint(x: 0.5809*width, y: 0.44755*height))
                    path.closeSubpath()
                    path.move(to: CGPoint(x: 0.401*width, y: 0.45011*height))
                    path.addCurve(to: CGPoint(x: 0.41021*width, y: 0.41221*height), control1: CGPoint(x: 0.401*width, y: 0.45011*height), control2: CGPoint(x: 0.38606*width, y: 0.43262*height))
                    path.addCurve(to: CGPoint(x: 0.44542*width, y: 0.43319*height), control1: CGPoint(x: 0.41475*width, y: 0.42043*height), control2: CGPoint(x: 0.43426*width, y: 0.43059*height))
                    path.addCurve(to: CGPoint(x: 0.42655*width, y: 0.43954*height), control1: CGPoint(x: 0.43891*width, y: 0.43562*height), control2: CGPoint(x: 0.43153*width, y: 0.43832*height))
                    path.addCurve(to: CGPoint(x: 0.401*width, y: 0.45011*height), control1: CGPoint(x: 0.41794*width, y: 0.44167*height), control2: CGPoint(x: 0.40366*width, y: 0.44755*height))
                    path.closeSubpath()
                    return path
                        .scale(0.9875).path(in: rect)
                        .offsetBy(dx: -0.0005*rect.size.width, dy: -0.0005*rect.size.height)
                }
            }

            struct SerratusAnterior: Shape {
                func path(in rect: CGRect) -> Path {
                    var path = Path()
                    let width = rect.size.width
                    let height = rect.size.height
                    path.move(to: CGPoint(x: 0.57303*width, y: 0.40938*height))
                    path.addLine(to: CGPoint(x: 0.5691*width, y: 0.41465*height))
                    path.addLine(to: CGPoint(x: 0.55951*width, y: 0.42117*height))
                    path.addLine(to: CGPoint(x: 0.54303*width, y: 0.42918*height))
                    path.addLine(to: CGPoint(x: 0.53377*width, y: 0.43184*height))
                    path.addLine(to: CGPoint(x: 0.53347*width, y: 0.43046*height))
                    path.addLine(to: CGPoint(x: 0.53863*width, y: 0.41654*height))
                    path.addLine(to: CGPoint(x: 0.54657*width, y: 0.40242*height))
                    path.addLine(to: CGPoint(x: 0.55803*width, y: 0.38742*height))
                    path.addLine(to: CGPoint(x: 0.57333*width, y: 0.36684*height))
                    path.addLine(to: CGPoint(x: 0.57259*width, y: 0.38242*height))
                    path.closeSubpath()
                    path.move(to: CGPoint(x: 0.40794*width, y: 0.40938*height))
                    path.addLine(to: CGPoint(x: 0.4119*width, y: 0.41465*height))
                    path.addLine(to: CGPoint(x: 0.42146*width, y: 0.42117*height))
                    path.addLine(to: CGPoint(x: 0.43794*width, y: 0.42918*height))
                    path.addLine(to: CGPoint(x: 0.4472*width, y: 0.43184*height))
                    path.addLine(to: CGPoint(x: 0.4475*width, y: 0.43046*height))
                    path.addLine(to: CGPoint(x: 0.44236*width, y: 0.41654*height))
                    path.addLine(to: CGPoint(x: 0.43442*width, y: 0.40242*height))
                    path.addLine(to: CGPoint(x: 0.42294*width, y: 0.38742*height))
                    path.addLine(to: CGPoint(x: 0.40766*width, y: 0.36684*height))
                    path.addLine(to: CGPoint(x: 0.40838*width, y: 0.38242*height))
                    path.closeSubpath()
                    return path
                        .offsetBy(dx: 0.0015*rect.size.width, dy: 0.0025*rect.size.height)
                }
            }
        }

        struct Deltoids: Shape {
            func path(in rect: CGRect) -> Path {
                var path = Path()
                path.addPath(Deltoids().path(in: rect))
                path.addPath(Infraspinatus().path(in: rect))
                return path
                    .offsetBy(dx: 0.0075*rect.size.width, dy: -0.004*rect.size.height)
            }

            struct Deltoids: Shape {
                func path(in rect: CGRect) -> Path {
                    var path = Path()
                    let width = rect.size.width
                    let height = rect.size.height
                    path.move(to: CGPoint(x: 0.37662*width, y: 0.29316*height))
                    path.addCurve(to: CGPoint(x: 0.3422*width, y: 0.30319*height), control1: CGPoint(x: 0.36535*width, y: 0.29705*height), control2: CGPoint(x: 0.35306*width, y: 0.2986*height))
                    path.addCurve(to: CGPoint(x: 0.32437*width, y: 0.3137*height), control1: CGPoint(x: 0.33553*width, y: 0.30603*height), control2: CGPoint(x: 0.32979*width, y: 0.30978*height))
                    path.addCurve(to: CGPoint(x: 0.31914*width, y: 0.29907*height), control1: CGPoint(x: 0.32326*width, y: 0.31142*height), control2: CGPoint(x: 0.32072*width, y: 0.30579*height))
                    path.addCurve(to: CGPoint(x: 0.3316*width, y: 0.2594*height), control1: CGPoint(x: 0.31708*width, y: 0.29034*height), control2: CGPoint(x: 0.32616*width, y: 0.2686*height))
                    path.addCurve(to: CGPoint(x: 0.34778*width, y: 0.24985*height), control1: CGPoint(x: 0.33491*width, y: 0.25381*height), control2: CGPoint(x: 0.34174*width, y: 0.25171*height))
                    path.addCurve(to: CGPoint(x: 0.35338*width, y: 0.24795*height), control1: CGPoint(x: 0.34977*width, y: 0.24923*height), control2: CGPoint(x: 0.35171*width, y: 0.24864*height))
                    path.addCurve(to: CGPoint(x: 0.38176*width, y: 0.25806*height), control1: CGPoint(x: 0.36412*width, y: 0.24898*height), control2: CGPoint(x: 0.37301*width, y: 0.25247*height))
                    path.addCurve(to: CGPoint(x: 0.37662*width, y: 0.29316*height), control1: CGPoint(x: 0.39706*width, y: 0.26784*height), control2: CGPoint(x: 0.39463*width, y: 0.28698*height))
                    path.move(to: CGPoint(x: 0.60759*width, y: 0.29316*height))
                    path.addCurve(to: CGPoint(x: 0.64201*width, y: 0.30319*height), control1: CGPoint(x: 0.61887*width, y: 0.29705*height), control2: CGPoint(x: 0.63116*width, y: 0.2986*height))
                    path.addCurve(to: CGPoint(x: 0.65984*width, y: 0.3137*height), control1: CGPoint(x: 0.64868*width, y: 0.30603*height), control2: CGPoint(x: 0.65442*width, y: 0.30978*height))
                    path.addCurve(to: CGPoint(x: 0.66507*width, y: 0.29907*height), control1: CGPoint(x: 0.66095*width, y: 0.31142*height), control2: CGPoint(x: 0.6635*width, y: 0.30579*height))
                    path.addCurve(to: CGPoint(x: 0.65262*width, y: 0.2594*height), control1: CGPoint(x: 0.66713*width, y: 0.29034*height), control2: CGPoint(x: 0.65806*width, y: 0.2686*height))
                    path.addCurve(to: CGPoint(x: 0.63644*width, y: 0.24985*height), control1: CGPoint(x: 0.64931*width, y: 0.25381*height), control2: CGPoint(x: 0.64248*width, y: 0.25171*height))
                    path.addCurve(to: CGPoint(x: 0.63083*width, y: 0.24795*height), control1: CGPoint(x: 0.63444*width, y: 0.24923*height), control2: CGPoint(x: 0.6325*width, y: 0.24864*height))
                    path.addCurve(to: CGPoint(x: 0.60245*width, y: 0.25806*height), control1: CGPoint(x: 0.62009*width, y: 0.24898*height), control2: CGPoint(x: 0.6112*width, y: 0.25247*height))
                    path.addCurve(to: CGPoint(x: 0.60759*width, y: 0.29316*height), control1: CGPoint(x: 0.58715*width, y: 0.26784*height), control2: CGPoint(x: 0.58961*width, y: 0.28698*height))
                    return path
                }
            }

            struct Infraspinatus: Shape {
                func path(in rect: CGRect) -> Path {
                    var path = Path()
                    let width = rect.size.width
                    let height = rect.size.height
                    path.move(to: CGPoint(x: 0.54891*width, y: 0.28971*height))
                    path.addCurve(to: CGPoint(x: 0.55046*width, y: 0.29494*height), control1: CGPoint(x: 0.54958*width, y: 0.29148*height), control2: CGPoint(x: 0.55009*width, y: 0.29323*height))
                    path.addLine(to: CGPoint(x: 0.55076*width, y: 0.29509*height))
                    path.addCurve(to: CGPoint(x: 0.55586*width, y: 0.30006*height), control1: CGPoint(x: 0.55252*width, y: 0.29671*height), control2: CGPoint(x: 0.55424*width, y: 0.29836*height))
                    path.addCurve(to: CGPoint(x: 0.59164*width, y: 0.28435*height), control1: CGPoint(x: 0.56979*width, y: 0.29694*height), control2: CGPoint(x: 0.58229*width, y: 0.29194*height))
                    path.addCurve(to: CGPoint(x: 0.59046*width, y: 0.28233*height), control1: CGPoint(x: 0.5912*width, y: 0.28372*height), control2: CGPoint(x: 0.59081*width, y: 0.28306*height))
                    path.addCurve(to: CGPoint(x: 0.58852*width, y: 0.27079*height), control1: CGPoint(x: 0.58856*width, y: 0.27827*height), control2: CGPoint(x: 0.58799*width, y: 0.2744*height))
                    path.addLine(to: CGPoint(x: 0.5884*width, y: 0.27074*height))
                    path.addCurve(to: CGPoint(x: 0.56056*width, y: 0.25761*height), control1: CGPoint(x: 0.58042*width, y: 0.26514*height), control2: CGPoint(x: 0.57111*width, y: 0.26074*height))
                    path.addCurve(to: CGPoint(x: 0.55296*width, y: 0.25852*height), control1: CGPoint(x: 0.55803*width, y: 0.25782*height), control2: CGPoint(x: 0.55549*width, y: 0.2581*height))
                    path.addCurve(to: CGPoint(x: 0.54891*width, y: 0.28971*height), control1: CGPoint(x: 0.53352*width, y: 0.26181*height), control2: CGPoint(x: 0.54567*width, y: 0.28113*height))
                    path.move(to: CGPoint(x: 0.43079*width, y: 0.28951*height))
                    path.addCurve(to: CGPoint(x: 0.42924*width, y: 0.29474*height), control1: CGPoint(x: 0.43012*width, y: 0.29128*height), control2: CGPoint(x: 0.42961*width, y: 0.29302*height))
                    path.addLine(to: CGPoint(x: 0.42894*width, y: 0.29489*height))
                    path.addCurve(to: CGPoint(x: 0.42384*width, y: 0.29986*height), control1: CGPoint(x: 0.42718*width, y: 0.29651*height), control2: CGPoint(x: 0.42546*width, y: 0.29816*height))
                    path.addCurve(to: CGPoint(x: 0.38806*width, y: 0.28415*height), control1: CGPoint(x: 0.40991*width, y: 0.29674*height), control2: CGPoint(x: 0.39741*width, y: 0.29174*height))
                    path.addCurve(to: CGPoint(x: 0.38924*width, y: 0.28213*height), control1: CGPoint(x: 0.3885*width, y: 0.28352*height), control2: CGPoint(x: 0.38889*width, y: 0.28285*height))
                    path.addCurve(to: CGPoint(x: 0.39118*width, y: 0.27059*height), control1: CGPoint(x: 0.39113*width, y: 0.27807*height), control2: CGPoint(x: 0.39171*width, y: 0.2742*height))
                    path.addLine(to: CGPoint(x: 0.3913*width, y: 0.27054*height))
                    path.addCurve(to: CGPoint(x: 0.41914*width, y: 0.25741*height), control1: CGPoint(x: 0.39928*width, y: 0.26494*height), control2: CGPoint(x: 0.40859*width, y: 0.26054*height))
                    path.addCurve(to: CGPoint(x: 0.42674*width, y: 0.25832*height), control1: CGPoint(x: 0.42167*width, y: 0.25762*height), control2: CGPoint(x: 0.42421*width, y: 0.2579*height))
                    path.addCurve(to: CGPoint(x: 0.43079*width, y: 0.28951*height), control1: CGPoint(x: 0.4462*width, y: 0.26159*height), control2: CGPoint(x: 0.43403*width, y: 0.28091*height))
                    return path
                        .offsetBy(dx: 0.0025*rect.size.width, dy: 0.0005*rect.size.height)
                }
            }
        }

        struct Trapezii: Shape {
            func path(in rect: CGRect) -> Path {
                var path = Path()
                path.addPath(TrapeziusLower().path(in: rect))
                path.addPath(TrapeziusUpper().path(in: rect))
                return path
                    .offsetBy(dx: 0.0078*rect.size.width, dy: -0.004*rect.size.height)
            }

            struct TrapeziusLower: Shape {
                func path(in rect: CGRect) -> Path {
                    var path = Path()
                    let width = rect.size.width
                    let height = rect.size.height
                    path.move(to: CGPoint(x: 0.49718*width, y: 0.34488*height))
                    path.addCurve(to: CGPoint(x: 0.4978*width, y: 0.36272*height), control1: CGPoint(x: 0.49731*width, y: 0.35082*height), control2: CGPoint(x: 0.49789*width, y: 0.35677*height))
                    path.addCurve(to: CGPoint(x: 0.50931*width, y: 0.36054*height), control1: CGPoint(x: 0.49771*width, y: 0.36739*height), control2: CGPoint(x: 0.50694*width, y: 0.36276*height))
                    path.addCurve(to: CGPoint(x: 0.51919*width, y: 0.35139*height), control1: CGPoint(x: 0.51257*width, y: 0.35747*height), control2: CGPoint(x: 0.516*width, y: 0.35449*height))
                    path.addCurve(to: CGPoint(x: 0.54782*width, y: 0.32147*height), control1: CGPoint(x: 0.52917*width, y: 0.34165*height), control2: CGPoint(x: 0.53998*width, y: 0.33208*height))
                    path.addCurve(to: CGPoint(x: 0.54613*width, y: 0.2783*height), control1: CGPoint(x: 0.55868*width, y: 0.30682*height), control2: CGPoint(x: 0.55106*width, y: 0.29309*height))
                    path.addCurve(to: CGPoint(x: 0.55067*width, y: 0.26134*height), control1: CGPoint(x: 0.54412*width, y: 0.27222*height), control2: CGPoint(x: 0.54218*width, y: 0.26528*height))
                    path.addCurve(to: CGPoint(x: 0.56769*width, y: 0.25833*height), control1: CGPoint(x: 0.55525*width, y: 0.25921*height), control2: CGPoint(x: 0.56243*width, y: 0.25889*height))
                    path.addCurve(to: CGPoint(x: 0.57516*width, y: 0.2579*height), control1: CGPoint(x: 0.57021*width, y: 0.25807*height), control2: CGPoint(x: 0.57264*width, y: 0.25799*height))
                    path.addCurve(to: CGPoint(x: 0.59843*width, y: 0.24826*height), control1: CGPoint(x: 0.58262*width, y: 0.25759*height), control2: CGPoint(x: 0.60039*width, y: 0.25702*height))
                    path.addCurve(to: CGPoint(x: 0.55481*width, y: 0.24711*height), control1: CGPoint(x: 0.58317*width, y: 0.25*height), control2: CGPoint(x: 0.56356*width, y: 0.24801*height))
                    path.addCurve(to: CGPoint(x: 0.52688*width, y: 0.24097*height), control1: CGPoint(x: 0.54491*width, y: 0.2461*height), control2: CGPoint(x: 0.53537*width, y: 0.24406*height))
                    path.addCurve(to: CGPoint(x: 0.49794*width, y: 0.26559*height), control1: CGPoint(x: 0.51238*width, y: 0.24633*height), control2: CGPoint(x: 0.50215*width, y: 0.25451*height))
                    path.addCurve(to: CGPoint(x: 0.49755*width, y: 0.30762*height), control1: CGPoint(x: 0.49278*width, y: 0.27907*height), control2: CGPoint(x: 0.49678*width, y: 0.29392*height))
                    path.addCurve(to: CGPoint(x: 0.49718*width, y: 0.34488*height), control1: CGPoint(x: 0.49831*width, y: 0.32*height), control2: CGPoint(x: 0.49692*width, y: 0.33247*height))
                    path.move(to: CGPoint(x: 0.49072*width, y: 0.34485*height))
                    path.addCurve(to: CGPoint(x: 0.49009*width, y: 0.36269*height), control1: CGPoint(x: 0.49058*width, y: 0.35079*height), control2: CGPoint(x: 0.49*width, y: 0.35674*height))
                    path.addCurve(to: CGPoint(x: 0.47859*width, y: 0.36051*height), control1: CGPoint(x: 0.49019*width, y: 0.36736*height), control2: CGPoint(x: 0.48095*width, y: 0.36273*height))
                    path.addCurve(to: CGPoint(x: 0.4687*width, y: 0.35136*height), control1: CGPoint(x: 0.47532*width, y: 0.35744*height), control2: CGPoint(x: 0.4719*width, y: 0.35446*height))
                    path.addCurve(to: CGPoint(x: 0.44007*width, y: 0.32144*height), control1: CGPoint(x: 0.45873*width, y: 0.34162*height), control2: CGPoint(x: 0.44792*width, y: 0.33205*height))
                    path.addCurve(to: CGPoint(x: 0.44176*width, y: 0.27827*height), control1: CGPoint(x: 0.42921*width, y: 0.30679*height), control2: CGPoint(x: 0.43683*width, y: 0.29306*height))
                    path.addCurve(to: CGPoint(x: 0.43722*width, y: 0.26131*height), control1: CGPoint(x: 0.44377*width, y: 0.27219*height), control2: CGPoint(x: 0.44572*width, y: 0.26525*height))
                    path.addCurve(to: CGPoint(x: 0.42021*width, y: 0.2583*height), control1: CGPoint(x: 0.43264*width, y: 0.25918*height), control2: CGPoint(x: 0.42546*width, y: 0.25886*height))
                    path.addCurve(to: CGPoint(x: 0.41273*width, y: 0.25787*height), control1: CGPoint(x: 0.41769*width, y: 0.25804*height), control2: CGPoint(x: 0.41525*width, y: 0.25796*height))
                    path.addCurve(to: CGPoint(x: 0.38947*width, y: 0.24823*height), control1: CGPoint(x: 0.40528*width, y: 0.25756*height), control2: CGPoint(x: 0.3875*width, y: 0.25699*height))
                    path.addCurve(to: CGPoint(x: 0.43308*width, y: 0.24708*height), control1: CGPoint(x: 0.40472*width, y: 0.24997*height), control2: CGPoint(x: 0.42433*width, y: 0.24798*height))
                    path.addCurve(to: CGPoint(x: 0.46102*width, y: 0.24094*height), control1: CGPoint(x: 0.44299*width, y: 0.24606*height), control2: CGPoint(x: 0.45252*width, y: 0.24403*height))
                    path.addCurve(to: CGPoint(x: 0.48995*width, y: 0.26556*height), control1: CGPoint(x: 0.47551*width, y: 0.2463*height), control2: CGPoint(x: 0.48574*width, y: 0.25448*height))
                    path.addCurve(to: CGPoint(x: 0.49035*width, y: 0.30759*height), control1: CGPoint(x: 0.49512*width, y: 0.27904*height), control2: CGPoint(x: 0.49111*width, y: 0.29389*height))
                    path.addCurve(to: CGPoint(x: 0.49072*width, y: 0.34485*height), control1: CGPoint(x: 0.48958*width, y: 0.31997*height), control2: CGPoint(x: 0.491*width, y: 0.33244*height))
                    return path
                        .offsetBy(dx: -0.00175*rect.size.width, dy: -0.0015*rect.size.height)
                }
            }

            struct TrapeziusUpper: Shape {
                func path(in rect: CGRect) -> Path {
                    var path = Path()
                    let width = rect.size.width
                    let height = rect.size.height
                    path.move(to: CGPoint(x: 0.48912*width, y: 0.2017*height))
                    path.addCurve(to: CGPoint(x: 0.47968*width, y: 0.22512*height), control1: CGPoint(x: 0.48882*width, y: 0.21077*height), control2: CGPoint(x: 0.48792*width, y: 0.21752*height))
                    path.addCurve(to: CGPoint(x: 0.45181*width, y: 0.24117*height), control1: CGPoint(x: 0.47127*width, y: 0.23287*height), control2: CGPoint(x: 0.46544*width, y: 0.2375*height))
                    path.addCurve(to: CGPoint(x: 0.37083*width, y: 0.24063*height), control1: CGPoint(x: 0.439*width, y: 0.24465*height), control2: CGPoint(x: 0.38343*width, y: 0.2529*height))
                    path.addCurve(to: CGPoint(x: 0.37479*width, y: 0.23849*height), control1: CGPoint(x: 0.37211*width, y: 0.24012*height), control2: CGPoint(x: 0.37329*width, y: 0.2394*height))
                    path.addCurve(to: CGPoint(x: 0.39273*width, y: 0.22983*height), control1: CGPoint(x: 0.37792*width, y: 0.23659*height), control2: CGPoint(x: 0.38264*width, y: 0.23373*height))
                    path.addCurve(to: CGPoint(x: 0.41678*width, y: 0.22201*height), control1: CGPoint(x: 0.39861*width, y: 0.22755*height), control2: CGPoint(x: 0.40743*width, y: 0.22485*height))
                    path.addCurve(to: CGPoint(x: 0.45125*width, y: 0.20944*height), control1: CGPoint(x: 0.4316*width, y: 0.2175*height), control2: CGPoint(x: 0.44692*width, y: 0.21281*height))
                    path.addCurve(to: CGPoint(x: 0.4731*width, y: 0.1884*height), control1: CGPoint(x: 0.46123*width, y: 0.20406*height), control2: CGPoint(x: 0.46752*width, y: 0.196*height))
                    path.addCurve(to: CGPoint(x: 0.47669*width, y: 0.18336*height), control1: CGPoint(x: 0.47431*width, y: 0.18673*height), control2: CGPoint(x: 0.47544*width, y: 0.18503*height))
                    path.addCurve(to: CGPoint(x: 0.48317*width, y: 0.17892*height), control1: CGPoint(x: 0.47803*width, y: 0.18159*height), control2: CGPoint(x: 0.48025*width, y: 0.17968*height))
                    path.addCurve(to: CGPoint(x: 0.48887*width, y: 0.18154*height), control1: CGPoint(x: 0.48586*width, y: 0.17824*height), control2: CGPoint(x: 0.48863*width, y: 0.17978*height))
                    path.addCurve(to: CGPoint(x: 0.48942*width, y: 0.18616*height), control1: CGPoint(x: 0.48924*width, y: 0.18307*height), control2: CGPoint(x: 0.48942*width, y: 0.1846*height))
                    path.addCurve(to: CGPoint(x: 0.48912*width, y: 0.2017*height), control1: CGPoint(x: 0.48968*width, y: 0.1913*height), control2: CGPoint(x: 0.48928*width, y: 0.19653*height))
                    path.move(to: CGPoint(x: 0.49488*width, y: 0.2017*height))
                    path.addCurve(to: CGPoint(x: 0.50433*width, y: 0.22512*height), control1: CGPoint(x: 0.49516*width, y: 0.21077*height), control2: CGPoint(x: 0.49609*width, y: 0.21752*height))
                    path.addCurve(to: CGPoint(x: 0.5322*width, y: 0.24117*height), control1: CGPoint(x: 0.51273*width, y: 0.23287*height), control2: CGPoint(x: 0.51856*width, y: 0.2375*height))
                    path.addCurve(to: CGPoint(x: 0.61317*width, y: 0.24063*height), control1: CGPoint(x: 0.545*width, y: 0.24465*height), control2: CGPoint(x: 0.60058*width, y: 0.2529*height))
                    path.addCurve(to: CGPoint(x: 0.60921*width, y: 0.23849*height), control1: CGPoint(x: 0.6119*width, y: 0.24012*height), control2: CGPoint(x: 0.61072*width, y: 0.2394*height))
                    path.addCurve(to: CGPoint(x: 0.59127*width, y: 0.22983*height), control1: CGPoint(x: 0.60609*width, y: 0.23659*height), control2: CGPoint(x: 0.60137*width, y: 0.23373*height))
                    path.addCurve(to: CGPoint(x: 0.56722*width, y: 0.22201*height), control1: CGPoint(x: 0.58539*width, y: 0.22755*height), control2: CGPoint(x: 0.57657*width, y: 0.22485*height))
                    path.addCurve(to: CGPoint(x: 0.53275*width, y: 0.20944*height), control1: CGPoint(x: 0.55241*width, y: 0.2175*height), control2: CGPoint(x: 0.53708*width, y: 0.21281*height))
                    path.addCurve(to: CGPoint(x: 0.5109*width, y: 0.1884*height), control1: CGPoint(x: 0.52278*width, y: 0.20406*height), control2: CGPoint(x: 0.51648*width, y: 0.196*height))
                    path.addCurve(to: CGPoint(x: 0.50731*width, y: 0.18336*height), control1: CGPoint(x: 0.5097*width, y: 0.18673*height), control2: CGPoint(x: 0.50856*width, y: 0.18503*height))
                    path.addCurve(to: CGPoint(x: 0.50083*width, y: 0.17892*height), control1: CGPoint(x: 0.50597*width, y: 0.18159*height), control2: CGPoint(x: 0.50375*width, y: 0.17968*height))
                    path.addCurve(to: CGPoint(x: 0.49514*width, y: 0.18154*height), control1: CGPoint(x: 0.49815*width, y: 0.17824*height), control2: CGPoint(x: 0.49537*width, y: 0.17978*height))
                    path.addCurve(to: CGPoint(x: 0.49458*width, y: 0.18616*height), control1: CGPoint(x: 0.49477*width, y: 0.18307*height), control2: CGPoint(x: 0.49458*width, y: 0.1846*height))
                    path.addCurve(to: CGPoint(x: 0.49488*width, y: 0.2017*height), control1: CGPoint(x: 0.49433*width, y: 0.1913*height), control2: CGPoint(x: 0.49472*width, y: 0.19653*height))
                    return path
                }
            }
        }

        struct Triceps: Shape {
            func path(in rect: CGRect) -> Path {
                var path = Path()
                path.addPath(TricepsBrachiiLongLateralHeads().path(in: rect))
                return path
                    .offsetBy(dx: 0.00825*rect.size.width, dy: -0.006*rect.size.height)
            }

            struct TricepsBrachiiLongLateralHeads: Shape {
                func path(in rect: CGRect) -> Path {
                    var path = Path()
                    let width = rect.size.width
                    let height = rect.size.height
                    path.move(to: CGPoint(x: 0.59329*width, y: 0.33113*height))
                    path.addLine(to: CGPoint(x: 0.59329*width, y: 0.33114*height))
                    path.addCurve(to: CGPoint(x: 0.60975*width, y: 0.3539*height), control1: CGPoint(x: 0.59535*width, y: 0.33528*height), control2: CGPoint(x: 0.60338*width, y: 0.34718*height))
                    path.addCurve(to: CGPoint(x: 0.61986*width, y: 0.37346*height), control1: CGPoint(x: 0.61461*width, y: 0.35906*height), control2: CGPoint(x: 0.61808*width, y: 0.36802*height))
                    path.addCurve(to: CGPoint(x: 0.64025*width, y: 0.38588*height), control1: CGPoint(x: 0.62398*width, y: 0.37903*height), control2: CGPoint(x: 0.62963*width, y: 0.3835*height))
                    path.addCurve(to: CGPoint(x: 0.64407*width, y: 0.38664*height), control1: CGPoint(x: 0.64148*width, y: 0.38616*height), control2: CGPoint(x: 0.64278*width, y: 0.3864*height))
                    path.addCurve(to: CGPoint(x: 0.62412*width, y: 0.35281*height), control1: CGPoint(x: 0.63491*width, y: 0.376*height), control2: CGPoint(x: 0.63002*width, y: 0.36451*height))
                    path.addCurve(to: CGPoint(x: 0.62502*width, y: 0.33856*height), control1: CGPoint(x: 0.62336*width, y: 0.35128*height), control2: CGPoint(x: 0.61574*width, y: 0.3379*height))
                    path.addCurve(to: CGPoint(x: 0.64206*width, y: 0.35383*height), control1: CGPoint(x: 0.63398*width, y: 0.33921*height), control2: CGPoint(x: 0.63903*width, y: 0.34934*height))
                    path.addCurve(to: CGPoint(x: 0.65523*width, y: 0.38696*height), control1: CGPoint(x: 0.64917*width, y: 0.36441*height), control2: CGPoint(x: 0.65368*width, y: 0.37543*height))
                    path.addCurve(to: CGPoint(x: 0.66106*width, y: 0.38153*height), control1: CGPoint(x: 0.65775*width, y: 0.38602*height), control2: CGPoint(x: 0.65935*width, y: 0.38409*height))
                    path.addCurve(to: CGPoint(x: 0.67118*width, y: 0.36182*height), control1: CGPoint(x: 0.66481*width, y: 0.37591*height), control2: CGPoint(x: 0.66852*width, y: 0.36823*height))
                    path.addCurve(to: CGPoint(x: 0.66683*width, y: 0.33363*height), control1: CGPoint(x: 0.67065*width, y: 0.35605*height), control2: CGPoint(x: 0.6691*width, y: 0.3411*height))
                    path.addCurve(to: CGPoint(x: 0.65852*width, y: 0.31539*height), control1: CGPoint(x: 0.66396*width, y: 0.32434*height), control2: CGPoint(x: 0.65859*width, y: 0.31548*height))
                    path.addLine(to: CGPoint(x: 0.65833*width, y: 0.31509*height))
                    path.addLine(to: CGPoint(x: 0.6584*width, y: 0.31498*height))
                    path.addCurve(to: CGPoint(x: 0.61495*width, y: 0.29636*height), control1: CGPoint(x: 0.64595*width, y: 0.3066*height), control2: CGPoint(x: 0.63294*width, y: 0.3006*height))
                    path.addCurve(to: CGPoint(x: 0.60468*width, y: 0.29343*height), control1: CGPoint(x: 0.61144*width, y: 0.29554*height), control2: CGPoint(x: 0.60792*width, y: 0.2946*height))
                    path.addCurve(to: CGPoint(x: 0.59329*width, y: 0.33113*height), control1: CGPoint(x: 0.60294*width, y: 0.29944*height), control2: CGPoint(x: 0.59771*width, y: 0.31748*height))
                    path.move(to: CGPoint(x: 0.38931*width, y: 0.33113*height))
                    path.addLine(to: CGPoint(x: 0.38931*width, y: 0.33114*height))
                    path.addCurve(to: CGPoint(x: 0.37285*width, y: 0.3539*height), control1: CGPoint(x: 0.38725*width, y: 0.33528*height), control2: CGPoint(x: 0.37921*width, y: 0.34718*height))
                    path.addCurve(to: CGPoint(x: 0.36273*width, y: 0.37346*height), control1: CGPoint(x: 0.36799*width, y: 0.35906*height), control2: CGPoint(x: 0.36451*width, y: 0.36802*height))
                    path.addCurve(to: CGPoint(x: 0.34241*width, y: 0.38605*height), control1: CGPoint(x: 0.35861*width, y: 0.37903*height), control2: CGPoint(x: 0.35303*width, y: 0.38367*height))
                    path.addCurve(to: CGPoint(x: 0.33829*width, y: 0.38687*height), control1: CGPoint(x: 0.34118*width, y: 0.38633*height), control2: CGPoint(x: 0.33958*width, y: 0.38664*height))
                    path.addCurve(to: CGPoint(x: 0.35847*width, y: 0.35279*height), control1: CGPoint(x: 0.34745*width, y: 0.37623*height), control2: CGPoint(x: 0.35257*width, y: 0.36451*height))
                    path.addCurve(to: CGPoint(x: 0.35762*width, y: 0.33875*height), control1: CGPoint(x: 0.35924*width, y: 0.35127*height), control2: CGPoint(x: 0.3669*width, y: 0.33807*height))
                    path.addCurve(to: CGPoint(x: 0.34062*width, y: 0.35401*height), control1: CGPoint(x: 0.34866*width, y: 0.3394*height), control2: CGPoint(x: 0.34366*width, y: 0.34954*height))
                    path.addCurve(to: CGPoint(x: 0.32731*width, y: 0.38716*height), control1: CGPoint(x: 0.33352*width, y: 0.3646*height), control2: CGPoint(x: 0.32887*width, y: 0.37563*height))
                    path.addCurve(to: CGPoint(x: 0.32134*width, y: 0.38165*height), control1: CGPoint(x: 0.32479*width, y: 0.38622*height), control2: CGPoint(x: 0.32306*width, y: 0.38421*height))
                    path.addCurve(to: CGPoint(x: 0.31083*width, y: 0.36191*height), control1: CGPoint(x: 0.31759*width, y: 0.37603*height), control2: CGPoint(x: 0.31347*width, y: 0.36833*height))
                    path.addCurve(to: CGPoint(x: 0.31579*width, y: 0.33361*height), control1: CGPoint(x: 0.31137*width, y: 0.35614*height), control2: CGPoint(x: 0.3135*width, y: 0.34108*height))
                    path.addCurve(to: CGPoint(x: 0.3241*width, y: 0.31537*height), control1: CGPoint(x: 0.31866*width, y: 0.32432*height), control2: CGPoint(x: 0.32403*width, y: 0.31546*height))
                    path.addLine(to: CGPoint(x: 0.32428*width, y: 0.31508*height))
                    path.addLine(to: CGPoint(x: 0.32421*width, y: 0.31497*height))
                    path.addCurve(to: CGPoint(x: 0.36766*width, y: 0.29634*height), control1: CGPoint(x: 0.33667*width, y: 0.30659*height), control2: CGPoint(x: 0.34968*width, y: 0.30059*height))
                    path.addCurve(to: CGPoint(x: 0.37794*width, y: 0.29341*height), control1: CGPoint(x: 0.37118*width, y: 0.29552*height), control2: CGPoint(x: 0.3747*width, y: 0.29458*height))
                    path.addCurve(to: CGPoint(x: 0.38931*width, y: 0.33113*height), control1: CGPoint(x: 0.37968*width, y: 0.29944*height), control2: CGPoint(x: 0.38491*width, y: 0.31748*height))
                    return path
                        .scale(0.9925).path(in: rect)
                }
            }
        }
    }
}

#if DEBUG
#Preview {
    MusculoDiagramsView.PosteriorCoronal(presenting: [
        .abdominals { print("abdominals") },
//        .abductors { print("abductors") }, // Absent
        .adductors { print("adductors") },
        .biceps { print("biceps") },
        .calves(), // { print("calves") },
        .deltoids { print("deltoids") },
        .forearms { print("forearms") },
        .glutes { print("glutes") },
        .hamstrings { print("hamstrings") },
        .laterals(disabled: nil, action: nil),
        .lumbars(disabled: nil) { print("lumbars") },
        // .neck { print("neck") },
        .obliques(disabled: false) { print("obliques") },
        .pectorals { print("pectorals") },
        .quadriceps { print("quads") },
        .trapezii { print("trapezii") },
        .triceps(disabled: true, action: nil),
    ])
}
#endif
