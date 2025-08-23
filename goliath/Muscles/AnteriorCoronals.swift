//
//  AnteriorCoronals.swift
//  goliath
//
//  Created by Christophe Beaulieu on 2025-08-19.
//

import SwiftUI

extension MusculoDiagramsView {
    struct AnteriorCoronal: View {
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
                        case .abdominals(let disabled, let action): MusculoDiagramsView.draw(muscleGroup: Abdominals(), disabled: disabled, onTapPerform: action)
                        case .abductors(let disabled, let action): MusculoDiagramsView.draw(muscleGroup: Abductors(), disabled: disabled, onTapPerform: action)
                        case .adductors(let disabled, let action): MusculoDiagramsView.draw(muscleGroup: Adductors(), disabled: disabled, onTapPerform: action)
                        case .biceps(let disabled, let action): MusculoDiagramsView.draw(muscleGroup: Biceps(), disabled: disabled, onTapPerform: action)
                        case .calves(let disabled, let action): MusculoDiagramsView.draw(muscleGroup: Calves(), disabled: disabled, onTapPerform: action)
                        case .deltoids(let disabled, let action): MusculoDiagramsView.draw(muscleGroup: Deltoids(), disabled: disabled, onTapPerform: action)
                        case .forearms(let disabled, let action): MusculoDiagramsView.draw(muscleGroup: Forearms(), disabled: disabled, onTapPerform: action)
                        case .neck(let disabled, let action): MusculoDiagramsView.draw(muscleGroup: Neck(), disabled: disabled, onTapPerform: action)
                        case .obliques(let disabled, let action): MusculoDiagramsView.draw(muscleGroup: Obliques(), disabled: disabled, onTapPerform: action)
                        case .pectorals(let disabled, let action): MusculoDiagramsView.draw(muscleGroup: Pectorals(), disabled: disabled, onTapPerform: action)
                        case .quadriceps(let disabled, let action): MusculoDiagramsView.draw(muscleGroup: Quadriceps(), disabled: disabled, onTapPerform: action)
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

        struct Abdominals: Shape {
            func path(in rect: CGRect) -> Path {
                var path = Path()
                path.addPath(RectusAdominusLower().path(in: rect))
                path.addPath(RectusAbdominusUpper().path(in: rect))
                return path.offsetBy(dx: 0.057 * rect.size.width, dy: 0)
            }

            struct RectusAdominusLower: Shape {
                func path(in rect: CGRect) -> Path {
                    var path = Path()
                    let width = rect.size.width
                    let height = rect.size.height
                    path.move(to: CGPoint(x: 0.4344*width, y: 0.39508*height))
                    path.addCurve(to: CGPoint(x: 0.40773*width, y: 0.40066*height), control1: CGPoint(x: 0.42549*width, y: 0.39688*height), control2: CGPoint(x: 0.41662*width, y: 0.39877*height))
                    path.addCurve(to: CGPoint(x: 0.39431*width, y: 0.3929*height), control1: CGPoint(x: 0.39669*width, y: 0.40302*height), control2: CGPoint(x: 0.39437*width, y: 0.39731*height))
                    path.addCurve(to: CGPoint(x: 0.40174*width, y: 0.38164*height), control1: CGPoint(x: 0.39421*width, y: 0.38867*height), control2: CGPoint(x: 0.39766*width, y: 0.38478*height))
                    path.addCurve(to: CGPoint(x: 0.43039*width, y: 0.37432*height), control1: CGPoint(x: 0.40859*width, y: 0.37637*height), control2: CGPoint(x: 0.42028*width, y: 0.37472*height))
                    path.addCurve(to: CGPoint(x: 0.4344*width, y: 0.39508*height), control1: CGPoint(x: 0.44238*width, y: 0.37386*height), control2: CGPoint(x: 0.446*width, y: 0.39248*height))
                    path.move(to: CGPoint(x: 0.45363*width, y: 0.39519*height))
                    path.addCurve(to: CGPoint(x: 0.4803*width, y: 0.40077*height), control1: CGPoint(x: 0.46255*width, y: 0.39699*height), control2: CGPoint(x: 0.47141*width, y: 0.39887*height))
                    path.addCurve(to: CGPoint(x: 0.49373*width, y: 0.39301*height), control1: CGPoint(x: 0.49134*width, y: 0.40313*height), control2: CGPoint(x: 0.49366*width, y: 0.39742*height))
                    path.addCurve(to: CGPoint(x: 0.4863*width, y: 0.38174*height), control1: CGPoint(x: 0.49382*width, y: 0.38878*height), control2: CGPoint(x: 0.49037*width, y: 0.38489*height))
                    path.addCurve(to: CGPoint(x: 0.45764*width, y: 0.37443*height), control1: CGPoint(x: 0.47944*width, y: 0.37648*height), control2: CGPoint(x: 0.46775*width, y: 0.37483*height))
                    path.addCurve(to: CGPoint(x: 0.45363*width, y: 0.39519*height), control1: CGPoint(x: 0.44565*width, y: 0.37395*height), control2: CGPoint(x: 0.44204*width, y: 0.39258*height))
                    path.move(to: CGPoint(x: 0.43778*width, y: 0.44673*height))
                    path.addCurve(to: CGPoint(x: 0.43694*width, y: 0.46568*height), control1: CGPoint(x: 0.43752*width, y: 0.45304*height), control2: CGPoint(x: 0.43725*width, y: 0.45937*height))
                    path.addCurve(to: CGPoint(x: 0.41495*width, y: 0.4625*height), control1: CGPoint(x: 0.43648*width, y: 0.47586*height), control2: CGPoint(x: 0.41882*width, y: 0.46545*height))
                    path.addCurve(to: CGPoint(x: 0.39745*width, y: 0.42508*height), control1: CGPoint(x: 0.404*width, y: 0.45174*height), control2: CGPoint(x: 0.40109*width, y: 0.43759*height))
                    path.addCurve(to: CGPoint(x: 0.41532*width, y: 0.40321*height), control1: CGPoint(x: 0.39444*width, y: 0.41475*height), control2: CGPoint(x: 0.39949*width, y: 0.4064*height))
                    path.addCurve(to: CGPoint(x: 0.43928*width, y: 0.41042*height), control1: CGPoint(x: 0.42646*width, y: 0.40097*height), control2: CGPoint(x: 0.43838*width, y: 0.40076*height))
                    path.addCurve(to: CGPoint(x: 0.43778*width, y: 0.44673*height), control1: CGPoint(x: 0.44032*width, y: 0.42238*height), control2: CGPoint(x: 0.43831*width, y: 0.43477*height))
                    path.move(to: CGPoint(x: 0.45032*width, y: 0.44673*height))
                    path.addCurve(to: CGPoint(x: 0.45116*width, y: 0.46568*height), control1: CGPoint(x: 0.45058*width, y: 0.45304*height), control2: CGPoint(x: 0.45086*width, y: 0.45937*height))
                    path.addCurve(to: CGPoint(x: 0.47315*width, y: 0.4625*height), control1: CGPoint(x: 0.45162*width, y: 0.47586*height), control2: CGPoint(x: 0.46928*width, y: 0.46545*height))
                    path.addCurve(to: CGPoint(x: 0.49065*width, y: 0.42508*height), control1: CGPoint(x: 0.4841*width, y: 0.45174*height), control2: CGPoint(x: 0.48701*width, y: 0.43759*height))
                    path.addCurve(to: CGPoint(x: 0.47278*width, y: 0.40321*height), control1: CGPoint(x: 0.49366*width, y: 0.41475*height), control2: CGPoint(x: 0.48861*width, y: 0.4064*height))
                    path.addCurve(to: CGPoint(x: 0.44882*width, y: 0.41042*height), control1: CGPoint(x: 0.46164*width, y: 0.40097*height), control2: CGPoint(x: 0.44972*width, y: 0.40076*height))
                    path.addCurve(to: CGPoint(x: 0.45032*width, y: 0.44673*height), control1: CGPoint(x: 0.44775*width, y: 0.42238*height), control2: CGPoint(x: 0.44979*width, y: 0.43477*height))
                    return path
                }
            }

            struct RectusAbdominusUpper: Shape {
                func path(in rect: CGRect) -> Path {
                    var path = Path()
                    let width = rect.size.width
                    let height = rect.size.height
                    path.move(to: CGPoint(x: 0.429*width, y: 0.36931*height))
                    path.addCurve(to: CGPoint(x: 0.40699*width, y: 0.37356*height), control1: CGPoint(x: 0.42132*width, y: 0.37011*height), control2: CGPoint(x: 0.41431*width, y: 0.37188*height))
                    path.addCurve(to: CGPoint(x: 0.39972*width, y: 0.35546*height), control1: CGPoint(x: 0.38738*width, y: 0.37806*height), control2: CGPoint(x: 0.39433*width, y: 0.36122*height))
                    path.addCurve(to: CGPoint(x: 0.42991*width, y: 0.34355*height), control1: CGPoint(x: 0.40593*width, y: 0.3488*height), control2: CGPoint(x: 0.41854*width, y: 0.34495*height))
                    path.addCurve(to: CGPoint(x: 0.44021*width, y: 0.35664*height), control1: CGPoint(x: 0.44347*width, y: 0.34188*height), control2: CGPoint(x: 0.44042*width, y: 0.35259*height))
                    path.addCurve(to: CGPoint(x: 0.429*width, y: 0.36931*height), control1: CGPoint(x: 0.43993*width, y: 0.3621*height), control2: CGPoint(x: 0.44065*width, y: 0.36832*height))
                    path.move(to: CGPoint(x: 0.45769*width, y: 0.36932*height))
                    path.addCurve(to: CGPoint(x: 0.47998*width, y: 0.37361*height), control1: CGPoint(x: 0.46549*width, y: 0.37014*height), control2: CGPoint(x: 0.47257*width, y: 0.37191*height))
                    path.addCurve(to: CGPoint(x: 0.48727*width, y: 0.35552*height), control1: CGPoint(x: 0.49986*width, y: 0.37813*height), control2: CGPoint(x: 0.49275*width, y: 0.36128*height))
                    path.addCurve(to: CGPoint(x: 0.45664*width, y: 0.34356*height), control1: CGPoint(x: 0.48095*width, y: 0.34884*height), control2: CGPoint(x: 0.46817*width, y: 0.34498*height))
                    path.addCurve(to: CGPoint(x: 0.44627*width, y: 0.35662*height), control1: CGPoint(x: 0.44289*width, y: 0.34188*height), control2: CGPoint(x: 0.44604*width, y: 0.35259*height))
                    path.addCurve(to: CGPoint(x: 0.45769*width, y: 0.36932*height), control1: CGPoint(x: 0.4466*width, y: 0.36208*height), control2: CGPoint(x: 0.44588*width, y: 0.36832*height))
                    path.move(to: CGPoint(x: 0.43905*width, y: 0.32873*height))
                    path.addCurve(to: CGPoint(x: 0.42521*width, y: 0.33901*height), control1: CGPoint(x: 0.43762*width, y: 0.33383*height), control2: CGPoint(x: 0.43141*width, y: 0.33654*height))
                    path.addCurve(to: CGPoint(x: 0.39398*width, y: 0.34131*height), control1: CGPoint(x: 0.4187*width, y: 0.34157*height), control2: CGPoint(x: 0.39569*width, y: 0.35162*height))
                    path.addCurve(to: CGPoint(x: 0.40877*width, y: 0.32207*height), control1: CGPoint(x: 0.3925*width, y: 0.33239*height), control2: CGPoint(x: 0.39644*width, y: 0.32611*height))
                    path.addCurve(to: CGPoint(x: 0.43655*width, y: 0.31585*height), control1: CGPoint(x: 0.41627*width, y: 0.31961*height), control2: CGPoint(x: 0.42829*width, y: 0.31491*height))
                    path.addCurve(to: CGPoint(x: 0.43905*width, y: 0.32873*height), control1: CGPoint(x: 0.44229*width, y: 0.31809*height), control2: CGPoint(x: 0.43998*width, y: 0.32542*height))
                    path.move(to: CGPoint(x: 0.44674*width, y: 0.32878*height))
                    path.addCurve(to: CGPoint(x: 0.46058*width, y: 0.33906*height), control1: CGPoint(x: 0.44817*width, y: 0.33387*height), control2: CGPoint(x: 0.45438*width, y: 0.33659*height))
                    path.addCurve(to: CGPoint(x: 0.49181*width, y: 0.34136*height), control1: CGPoint(x: 0.46708*width, y: 0.34162*height), control2: CGPoint(x: 0.49009*width, y: 0.35167*height))
                    path.addCurve(to: CGPoint(x: 0.47701*width, y: 0.32211*height), control1: CGPoint(x: 0.49329*width, y: 0.33244*height), control2: CGPoint(x: 0.48935*width, y: 0.32616*height))
                    path.addCurve(to: CGPoint(x: 0.44924*width, y: 0.3159*height), control1: CGPoint(x: 0.46951*width, y: 0.31966*height), control2: CGPoint(x: 0.4575*width, y: 0.31495*height))
                    path.addCurve(to: CGPoint(x: 0.44674*width, y: 0.32878*height), control1: CGPoint(x: 0.4435*width, y: 0.31812*height), control2: CGPoint(x: 0.44581*width, y: 0.32546*height))
                    return path
                }
            }
        }

        struct Abductors: Shape {
            func path(in rect: CGRect) -> Path {
                var path = Path()
                path.addPath(TensorFasciaeLatae().path(in: rect))
                return path.offsetBy(dx: 0.018 * rect.size.width, dy: 0)
            }

            struct TensorFasciaeLatae: Shape {
                func path(in rect: CGRect) -> Path {
                    var path = Path()
                    let width = rect.size.width
                    let height = rect.size.height
                    path.move(to: CGPoint(x: 0.39785*width, y: 0.47556*height))
                    path.addCurve(to: CGPoint(x: 0.3769*width, y: 0.50756*height), control1: CGPoint(x: 0.39558*width, y: 0.4866*height), control2: CGPoint(x: 0.39257*width, y: 0.50173*height))
                    path.addCurve(to: CGPoint(x: 0.37729*width, y: 0.50644*height), control1: CGPoint(x: 0.37701*width, y: 0.50718*height), control2: CGPoint(x: 0.37718*width, y: 0.50682*height))
                    path.addCurve(to: CGPoint(x: 0.3838*width, y: 0.48114*height), control1: CGPoint(x: 0.38125*width, y: 0.49551*height), control2: CGPoint(x: 0.3844*width, y: 0.48687*height))
                    path.addCurve(to: CGPoint(x: 0.39062*width, y: 0.44623*height), control1: CGPoint(x: 0.38255*width, y: 0.46992*height), control2: CGPoint(x: 0.38748*width, y: 0.45434*height))
                    path.addCurve(to: CGPoint(x: 0.39819*width, y: 0.47361*height), control1: CGPoint(x: 0.40042*width, y: 0.45323*height), control2: CGPoint(x: 0.40009*width, y: 0.46434*height))
                    path.addLine(to: CGPoint(x: 0.39785*width, y: 0.47556*height))
                    path.closeSubpath()
                    path.move(to: CGPoint(x: 0.56685*width, y: 0.47392*height))
                    path.addCurve(to: CGPoint(x: 0.57375*width, y: 0.44506*height), control1: CGPoint(x: 0.56514*width, y: 0.46324*height), control2: CGPoint(x: 0.56414*width, y: 0.45218*height))
                    path.addCurve(to: CGPoint(x: 0.58139*width, y: 0.47998*height), control1: CGPoint(x: 0.57711*width, y: 0.45312*height), control2: CGPoint(x: 0.58236*width, y: 0.46875*height))
                    path.addCurve(to: CGPoint(x: 0.58928*width, y: 0.50696*height), control1: CGPoint(x: 0.58093*width, y: 0.48571*height), control2: CGPoint(x: 0.58887*width, y: 0.49901*height))
                    path.addCurve(to: CGPoint(x: 0.56685*width, y: 0.47392*height), control1: CGPoint(x: 0.5781*width, y: 0.50511*height), control2: CGPoint(x: 0.56993*width, y: 0.49299*height))
                    path.closeSubpath()
                    return path.offsetBy(dx: -0.001 * rect.size.width, dy: 0)
                }
            }
        }

        struct Adductors: Shape {
            func path(in rect: CGRect) -> Path {
                var path = Path()
                path.addPath(AdductorLongusAndPectineus().path(in: rect))
                path.addPath(Sartorius().path(in: rect))
                return path.offsetBy(dx: 0.018 * rect.size.width, dy: 0)
            }

            struct AdductorLongusAndPectineus: Shape {
                func path(in rect: CGRect) -> Path {
                    // TODO: Fix me
                    var path = Path()
                    let width = rect.size.width
                    let height = rect.size.height
                    
                    // Left
                    path.move(to: CGPoint(x: 0.46407*width, y: 0.57914*height))
                    path.addCurve(to: CGPoint(x: 0.46322*width, y: 0.57079*height), control1: CGPoint(x: 0.46387*width, y: 0.57667*height), control2: CGPoint(x: 0.46356*width, y: 0.57324*height))
//                    path.addCurve(to: CGPoint(x: 0.46266*width, y: 0.56696*height), control1: CGPoint(x: 0.46306*width, y: 0.56951*height), control2: CGPoint(x: 0.46287*width, y: 0.56824*height))
                    path.addCurve(to: CGPoint(x: 0.47745*width, y: 0.51625*height), control1: CGPoint(x: 0.47546*width, y: 0.51606*height), control2: CGPoint(x: 0.47657*width, y: 0.51617*height))
//                    path.addCurve(to: CGPoint(x: 0.4785*width, y: 0.52211*height), control1: CGPoint(x: 0.47775*width, y: 0.51748*height), control2: CGPoint(x: 0.47817*width, y: 0.51954*height))
                    path.addCurve(to: CGPoint(x: 0.47889*width, y: 0.5288*height), control1: CGPoint(x: 0.47875*width, y: 0.52412*height), control2: CGPoint(x: 0.47894*width, y: 0.52639*height))
//                    path.addCurve(to: CGPoint(x: 0.47764*width, y: 0.53793*height), control1: CGPoint(x: 0.47819*width, y: 0.53542*height), control2: CGPoint(x: 0.47799*width, y: 0.53667*height))
//                    path.addCurve(to: CGPoint(x: 0.47493*width, y: 0.54642*height), control1: CGPoint(x: 0.47697*width, y: 0.54034*height), control2: CGPoint(x: 0.47602*width, y: 0.54319*height))
//                    path.addCurve(to: CGPoint(x: 0.47262*width, y: 0.55298*height), control1: CGPoint(x: 0.47424*width, y: 0.54847*height), control2: CGPoint(x: 0.47338*width, y: 0.55071*height))
                    path.addCurve(to: CGPoint(x: 0.4703*width, y: 0.55961*height), control1: CGPoint(x: 0.47185*width, y: 0.55525*height), control2: CGPoint(x: 0.47116*width, y: 0.55731*height))
//                    path.addCurve(to: CGPoint(x: 0.46782*width, y: 0.56684*height), control1: CGPoint(x: 0.46944*width, y: 0.56191*height), control2: CGPoint(x: 0.46861*width, y: 0.5644*height))
//                    path.addCurve(to: CGPoint(x: 0.46414*width, y: 0.57869*height), control1: CGPoint(x: 0.4666*width, y: 0.57057*height), control2: CGPoint(x: 0.46523*width, y: 0.57485*height))
                    path.closeSubpath()
                    
//                    path.move(to: CGPoint(x: 0.46176*width, y: 0.56162*height))
//                    path.addCurve(to: CGPoint(x: 0.46132*width, y: 0.55954*height), control1: CGPoint(x: 0.46162*width, y: 0.56093*height), control2: CGPoint(x: 0.46146*width, y: 0.56023*height))
//                    path.addCurve(to: CGPoint(x: 0.45856*width, y: 0.54901*height), control1: CGPoint(x: 0.46056*width, y: 0.55603*height), control2: CGPoint(x: 0.45965*width, y: 0.5525*height))
//                    path.addCurve(to: CGPoint(x: 0.45625*width, y: 0.54238*height), control1: CGPoint(x: 0.45787*width, y: 0.54679*height), control2: CGPoint(x: 0.45711*width, y: 0.54457*height))
//                    path.move(to: CGPoint(x: 0.45519*width, y: 0.5402*height))
//                    path.addCurve(to: CGPoint(x: 0.45407*width, y: 0.53775*height), control1: CGPoint(x: 0.45519*width, y: 0.54105*height), control2: CGPoint(x: 0.45447*width, y: 0.53855*height))
//                    path.addCurve(to: CGPoint(x: 0.45255*width, y: 0.53475*height), control1: CGPoint(x: 0.45368*width, y: 0.53694*height), control2: CGPoint(x: 0.45308*width, y: 0.53574*height))
//                    path.addCurve(to: CGPoint(x: 0.45109*width, y: 0.53222*height), control1: CGPoint(x: 0.45201*width, y: 0.53377*height), control2: CGPoint(x: 0.45157*width, y: 0.53307*height))
//                    path.closeSubpath()
                    
//                    path.move(to: CGPoint(x: 0.45009*width, y: 0.5306*height))
//                    path.addLine(to: CGPoint(x: 0.44975*width, y: 0.53005*height))
//                    path.addCurve(to: CGPoint(x: 0.44525*width, y: 0.52262*height), control1: CGPoint(x: 0.44826*width, y: 0.52761*height), control2: CGPoint(x: 0.44681*width, y: 0.52505*height))
//                    path.addLine(to: CGPoint(x: 0.44359*width, y: 0.52002*height))
//                    path.addLine(to: CGPoint(x: 0.45662*width, y: 0.50562*height))
//                    path.closeSubpath()
                    
                    path.move(to: CGPoint(x: 0.44287*width, y: 0.51886*height))
                    path.addCurve(to: CGPoint(x: 0.43808*width, y: 0.51048*height), control1: CGPoint(x: 0.44116*width, y: 0.5161*height), control2: CGPoint(x: 0.43951*width, y: 0.51332*height))
                    path.addLine(to: CGPoint(x: 0.43787*width, y: 0.51005*height))
                    path.addCurve(to: CGPoint(x: 0.45181*width, y: 0.49852*height), control1: CGPoint(x: 0.45153*width, y: 0.49802*height), control2: CGPoint(x: 0.45164*width, y: 0.49827*height))
                    path.addCurve(to: CGPoint(x: 0.45611*width, y: 0.50423*height), control1: CGPoint(x: 0.45308*width, y: 0.50049*height), control2: CGPoint(x: 0.45461*width, y: 0.50227*height))
//                    path.addLine(to: CGPoint(x: 0.44685*width, y: 0.51454*height))
                    path.addLine(to: CGPoint(x: 0.44296*width, y: 0.51886*height))
                    
                    path.move(to: CGPoint(x: 0.43736*width, y: 0.50881*height))
                    path.addCurve(to: CGPoint(x: 0.43639*width, y: 0.5067*height), control1: CGPoint(x: 0.43701*width, y: 0.5081*height), control2: CGPoint(x: 0.43669*width, y: 0.50739*height))
                    path.addCurve(to: CGPoint(x: 0.43424*width, y: 0.5014*height), control1: CGPoint(x: 0.4356*width, y: 0.50494*height), control2: CGPoint(x: 0.43488*width, y: 0.50318*height))
                    path.addCurve(to: CGPoint(x: 0.44873*width, y: 0.49386*height), control1: CGPoint(x: 0.44771*width, y: 0.49248*height), control2: CGPoint(x: 0.44822*width, y: 0.49316*height))
                    path.addCurve(to: CGPoint(x: 0.45069*width, y: 0.49679*height), control1: CGPoint(x: 0.4494*width, y: 0.4948*height), control2: CGPoint(x: 0.45005*width, y: 0.49579*height))

                    path.move(to: CGPoint(x: 0.4338*width, y: 0.50019*height))
                    path.addCurve(to: CGPoint(x: 0.43227*width, y: 0.49565*height), control1: CGPoint(x: 0.43324*width, y: 0.49864*height), control2: CGPoint(x: 0.43275*width, y: 0.4971*height))
                    path.addCurve(to: CGPoint(x: 0.4437*width, y: 0.4877*height), control1: CGPoint(x: 0.43576*width, y: 0.49299*height), control2: CGPoint(x: 0.43961*width, y: 0.49032*height))
                    path.addCurve(to: CGPoint(x: 0.44639*width, y: 0.4909*height), control1: CGPoint(x: 0.44458*width, y: 0.48875*height), control2: CGPoint(x: 0.44546*width, y: 0.48983*height))
                    path.addCurve(to: CGPoint(x: 0.4338*width, y: 0.50015*height), control1: CGPoint(x: 0.44192*width, y: 0.49389*height), control2: CGPoint(x: 0.43771*width, y: 0.49699*height))
                    
                    path.move(to: CGPoint(x: 0.43188*width, y: 0.49438*height))
                    path.addCurve(to: CGPoint(x: 0.42856*width, y: 0.48248*height), control1: CGPoint(x: 0.43067*width, y: 0.49042*height), control2: CGPoint(x: 0.42956*width, y: 0.48645*height))
                    path.addCurve(to: CGPoint(x: 0.42606*width, y: 0.47323*height), control1: CGPoint(x: 0.42775*width, y: 0.4794*height), control2: CGPoint(x: 0.42694*width, y: 0.47631*height))
                    path.addQuadCurve(to: CGPoint(x: 0.42938*width, y: 0.46924*height), control: CGPoint(x: 0.4269*width, y: 0.46586*height))
                    path.addCurve(to: CGPoint(x: 0.43169*width, y: 0.47225*height), control1: CGPoint(x: 0.43012*width, y: 0.47022*height), control2: CGPoint(x: 0.43086*width, y: 0.47122*height))
                    path.addCurve(to: CGPoint(x: 0.44095*width, y: 0.48407*height), control1: CGPoint(x: 0.43447*width, y: 0.47596*height), control2: CGPoint(x: 0.43748*width, y: 0.47997*height))
                    path.addCurve(to: CGPoint(x: 0.4431*width, y: 0.48673*height), control1: CGPoint(x: 0.44164*width, y: 0.48495*height), control2: CGPoint(x: 0.44236*width, y: 0.48583*height))
                    path.addCurve(to: CGPoint(x: 0.43204*width, y: 0.49437*height), control1: CGPoint(x: 0.43914*width, y: 0.48924*height), control2: CGPoint(x: 0.43544*width, y: 0.49181*height))
                    
                    // Right
                    path.move(to: CGPoint(x: 0.49801*width, y: 0.57944*height))
                    path.addCurve(to: CGPoint(x: 0.496*width, y: 0.56659*height), control1: CGPoint(x: 0.49692*width, y: 0.57563*height), control2: CGPoint(x: 0.49722*width, y: 0.57031*height))
                    path.addCurve(to: CGPoint(x: 0.49368*width, y: 0.55949*height), control1: CGPoint(x: 0.49521*width, y: 0.56417*height), control2: CGPoint(x: 0.4944*width, y: 0.56181*height))
                    path.addCurve(to: CGPoint(x: 0.49137*width, y: 0.55285*height), control1: CGPoint(x: 0.49296*width, y: 0.55718*height), control2: CGPoint(x: 0.49211*width, y: 0.55497*height))
                    path.addCurve(to: CGPoint(x: 0.48905*width, y: 0.5464*height), control1: CGPoint(x: 0.49062*width, y: 0.55074*height), control2: CGPoint(x: 0.48981*width, y: 0.54843*height))
                    path.addCurve(to: CGPoint(x: 0.48632*width, y: 0.53792*height), control1: CGPoint(x: 0.48794*width, y: 0.54319*height), control2: CGPoint(x: 0.48699*width, y: 0.54031*height))
                    path.addCurve(to: CGPoint(x: 0.48551*width, y: 0.5346*height), control1: CGPoint(x: 0.48597*width, y: 0.53667*height), control2: CGPoint(x: 0.48569*width, y: 0.53556*height))
                    path.addCurve(to: CGPoint(x: 0.4853*width, y: 0.52224*height), control1: CGPoint(x: 0.48493*width, y: 0.5265*height), control2: CGPoint(x: 0.48507*width, y: 0.52427*height))
                    path.addCurve(to: CGPoint(x: 0.48641*width, y: 0.51636*height), control1: CGPoint(x: 0.48565*width, y: 0.51968*height), control2: CGPoint(x: 0.48611*width, y: 0.51761*height))
                    path.addCurve(to: CGPoint(x: 0.50083*width, y: 0.57059*height), control1: CGPoint(x: 0.50076*width, y: 0.56853*height), control2: CGPoint(x: 0.50097*width, y: 0.56932*height))
                    path.addCurve(to: CGPoint(x: 0.49986*width, y: 0.58208*height), control1: CGPoint(x: 0.50049*width, y: 0.57304*height), control2: CGPoint(x: 0.50007*width, y: 0.57963*height))
                    path.closeSubpath()
                    
//                    path.move(to: CGPoint(x: 0.50185*width, y: 0.56207*height))
//                    path.addCurve(to: CGPoint(x: 0.505*width, y: 0.54892*height), control1: CGPoint(x: 0.50644*width, y: 0.54451*height), control2: CGPoint(x: 0.50567*width, y: 0.54671*height))
//                    path.addCurve(to: CGPoint(x: 0.50231*width, y: 0.5594*height), control1: CGPoint(x: 0.50391*width, y: 0.55239*height), control2: CGPoint(x: 0.50308*width, y: 0.5559*height))
//                    path.addCurve(to: CGPoint(x: 0.50185*width, y: 0.56159*height), control1: CGPoint(x: 0.50218*width, y: 0.56008*height), control2: CGPoint(x: 0.50199*width, y: 0.56094*height))
//                    path.closeSubpath()
                    
//                    path.move(to: CGPoint(x: 0.50838*width, y: 0.54002*height))
//                    path.addCurve(to: CGPoint(x: 0.511*width, y: 0.53463*height), control1: CGPoint(x: 0.51194*width, y: 0.53293*height), control2: CGPoint(x: 0.51146*width, y: 0.53378*height))
//                    path.addCurve(to: CGPoint(x: 0.50949*width, y: 0.53759*height), control1: CGPoint(x: 0.51053*width, y: 0.53548*height), control2: CGPoint(x: 0.50998*width, y: 0.5366*height))
//                    path.addCurve(to: CGPoint(x: 0.50838*width, y: 0.54002*height), control1: CGPoint(x: 0.509*width, y: 0.53858*height), control2: CGPoint(x: 0.50873*width, y: 0.53921*height))
                    
//                    path.move(to: CGPoint(x: 0.5134*width, y: 0.53048*height))
//                    path.addLine(to: CGPoint(x: 0.52*width, y: 0.52009*height))
//                    path.addLine(to: CGPoint(x: 0.51833*width, y: 0.52269*height))
//                    path.addCurve(to: CGPoint(x: 0.5137*width, y: 0.52992*height), control1: CGPoint(x: 0.51678*width, y: 0.52509*height), control2: CGPoint(x: 0.51521*width, y: 0.5275*height))
//                    path.addLine(to: CGPoint(x: 0.51338*width, y: 0.53048*height))
                    
                    path.move(to: CGPoint(x: 0.52069*width, y: 0.51894*height))
                    path.addLine(to: CGPoint(x: 0.51681*width, y: 0.51466*height))
                    path.addLine(to: CGPoint(x: 0.50778*width, y: 0.50472*height))
                    path.addCurve(to: CGPoint(x: 0.51183*width, y: 0.49875*height), control1: CGPoint(x: 0.50926*width, y: 0.50276*height), control2: CGPoint(x: 0.51058*width, y: 0.50073*height))
                    path.addCurve(to: CGPoint(x: 0.51229*width, y: 0.49804*height), control1: CGPoint(x: 0.51199*width, y: 0.49852*height), control2: CGPoint(x: 0.51213*width, y: 0.49827*height))
                    path.addLine(to: CGPoint(x: 0.52549*width, y: 0.51062*height))
                    path.addCurve(to: CGPoint(x: 0.52069*width, y: 0.51894*height), control1: CGPoint(x: 0.52405*width, y: 0.51344*height), control2: CGPoint(x: 0.52241*width, y: 0.5162*height))
                    
                    path.move(to: CGPoint(x: 0.5263*width, y: 0.50895*height))
                    path.addCurve(to: CGPoint(x: 0.51493*width, y: 0.49407*height), control1: CGPoint(x: 0.51361*width, y: 0.496*height), control2: CGPoint(x: 0.51426*width, y: 0.49502*height))
                    path.addCurve(to: CGPoint(x: 0.51648*width, y: 0.49205*height), control1: CGPoint(x: 0.51544*width, y: 0.49338*height), control2: CGPoint(x: 0.51595*width, y: 0.4927*height))
                    path.addCurve(to: CGPoint(x: 0.52727*width, y: 0.50684*height), control1: CGPoint(x: 0.52877*width, y: 0.50335*height), control2: CGPoint(x: 0.52806*width, y: 0.50509*height))
                    path.addCurve(to: CGPoint(x: 0.5263*width, y: 0.50895*height), control1: CGPoint(x: 0.52697*width, y: 0.50755*height), control2: CGPoint(x: 0.52664*width, y: 0.50826*height))
                    
                    path.move(to: CGPoint(x: 0.52986*width, y: 0.50037*height))
                    path.addCurve(to: CGPoint(x: 0.51727*width, y: 0.49111*height), control1: CGPoint(x: 0.52595*width, y: 0.49721*height), control2: CGPoint(x: 0.52174*width, y: 0.4941*height))
                    path.addCurve(to: CGPoint(x: 0.51995*width, y: 0.48793*height), control1: CGPoint(x: 0.51819*width, y: 0.49003*height), control2: CGPoint(x: 0.51907*width, y: 0.48897*height))
                    path.addCurve(to: CGPoint(x: 0.53139*width, y: 0.49583*height), control1: CGPoint(x: 0.52405*width, y: 0.49054*height), control2: CGPoint(x: 0.52789*width, y: 0.49319*height))
                    path.addCurve(to: CGPoint(x: 0.52986*width, y: 0.50034*height), control1: CGPoint(x: 0.5309*width, y: 0.49738*height), control2: CGPoint(x: 0.53042*width, y: 0.49884*height))
                    
                    path.move(to: CGPoint(x: 0.53178*width, y: 0.4946*height))
                    path.addCurve(to: CGPoint(x: 0.52072*width, y: 0.48701*height), control1: CGPoint(x: 0.52838*width, y: 0.49205*height), control2: CGPoint(x: 0.52468*width, y: 0.48951*height))
                    path.addLine(to: CGPoint(x: 0.52287*width, y: 0.48437*height))
                    path.addCurve(to: CGPoint(x: 0.53213*width, y: 0.47261*height), control1: CGPoint(x: 0.52625*width, y: 0.48022*height), control2: CGPoint(x: 0.52926*width, y: 0.47628*height))
                    path.addLine(to: CGPoint(x: 0.53444*width, y: 0.4696*height))
                    path.addQuadCurve(to: CGPoint(x: 0.53924*width, y: 0.46329*height), control: CGPoint(x: 0.53694*width, y: 0.46627*height))
                    path.addCurve(to: CGPoint(x: 0.53525*width, y: 0.48282*height), control1: CGPoint(x: 0.53687*width, y: 0.47665*height), control2: CGPoint(x: 0.53606*width, y: 0.47974*height))
                    path.addCurve(to: CGPoint(x: 0.53194*width, y: 0.49466*height), control1: CGPoint(x: 0.53421*width, y: 0.48677*height), control2: CGPoint(x: 0.53315*width, y: 0.49073*height))
                    path.closeSubpath()
                    
                    return path
                }
            }

            struct Sartorius: Shape {
                func path(in rect: CGRect) -> Path {
                    var path = Path()
                    let width = rect.size.width
                    let height = rect.size.height
                    path.move(to: CGPoint(x: 0.46326*width, y: 0.58128*height))
                    path.addCurve(to: CGPoint(x: 0.46116*width, y: 0.59022*height), control1: CGPoint(x: 0.46248*width, y: 0.58427*height), control2: CGPoint(x: 0.46174*width, y: 0.58735*height))
                    path.addCurve(to: CGPoint(x: 0.4587*width, y: 0.60477*height), control1: CGPoint(x: 0.46035*width, y: 0.59452*height), control2: CGPoint(x: 0.4594*width, y: 0.59986*height))
                    path.addCurve(to: CGPoint(x: 0.441*width, y: 0.55025*height), control1: CGPoint(x: 0.45667*width, y: 0.58633*height), control2: CGPoint(x: 0.45229*width, y: 0.56758*height))
                    path.addCurve(to: CGPoint(x: 0.40324*width, y: 0.46173*height), control1: CGPoint(x: 0.42231*width, y: 0.52154*height), control2: CGPoint(x: 0.40417*width, y: 0.49358*height))
                    path.addCurve(to: CGPoint(x: 0.40398*width, y: 0.45579*height), control1: CGPoint(x: 0.40319*width, y: 0.45969*height), control2: CGPoint(x: 0.4034*width, y: 0.45779*height))
                    path.addCurve(to: CGPoint(x: 0.41687*width, y: 0.45981*height), control1: CGPoint(x: 0.4066*width, y: 0.44708*height), control2: CGPoint(x: 0.41507*width, y: 0.45782*height))
                    path.addCurve(to: CGPoint(x: 0.4237*width, y: 0.47022*height), control1: CGPoint(x: 0.42012*width, y: 0.4634*height), control2: CGPoint(x: 0.42294*width, y: 0.46585*height))
                    path.addCurve(to: CGPoint(x: 0.42512*width, y: 0.4769*height), control1: CGPoint(x: 0.42407*width, y: 0.47227*height), control2: CGPoint(x: 0.42444*width, y: 0.47485*height))
                    path.addCurve(to: CGPoint(x: 0.44137*width, y: 0.51826*height), control1: CGPoint(x: 0.42963*width, y: 0.49103*height), control2: CGPoint(x: 0.43375*width, y: 0.50465*height))
                    path.addCurve(to: CGPoint(x: 0.45278*width, y: 0.53671*height), control1: CGPoint(x: 0.44486*width, y: 0.52451*height), control2: CGPoint(x: 0.44937*width, y: 0.53043*height))
                    path.addCurve(to: CGPoint(x: 0.46005*width, y: 0.55898*height), control1: CGPoint(x: 0.45662*width, y: 0.54377*height), control2: CGPoint(x: 0.45826*width, y: 0.55162*height))
                    path.addCurve(to: CGPoint(x: 0.46326*width, y: 0.58083*height), control1: CGPoint(x: 0.46183*width, y: 0.56637*height), control2: CGPoint(x: 0.46289*width, y: 0.57336*height))
                    path.addLine(to: CGPoint(x: 0.46326*width, y: 0.58128*height))
                    path.closeSubpath()
                    path.move(to: CGPoint(x: 0.50051*width, y: 0.58091*height))
                    path.addCurve(to: CGPoint(x: 0.50252*width, y: 0.58972*height), control1: CGPoint(x: 0.5013*width, y: 0.5839*height), control2: CGPoint(x: 0.50197*width, y: 0.58685*height))
                    path.addCurve(to: CGPoint(x: 0.50498*width, y: 0.60378*height), control1: CGPoint(x: 0.50333*width, y: 0.59403*height), control2: CGPoint(x: 0.50428*width, y: 0.59887*height))
                    path.addCurve(to: CGPoint(x: 0.52238*width, y: 0.5498*height), control1: CGPoint(x: 0.50701*width, y: 0.58534*height), control2: CGPoint(x: 0.51106*width, y: 0.56711*height))
                    path.addCurve(to: CGPoint(x: 0.56106*width, y: 0.46128*height), control1: CGPoint(x: 0.54106*width, y: 0.5211*height), control2: CGPoint(x: 0.56016*width, y: 0.49313*height))
                    path.addCurve(to: CGPoint(x: 0.56007*width, y: 0.45469*height), control1: CGPoint(x: 0.56111*width, y: 0.45924*height), control2: CGPoint(x: 0.56088*width, y: 0.45665*height))
                    path.addCurve(to: CGPoint(x: 0.54549*width, y: 0.45986*height), control1: CGPoint(x: 0.55609*width, y: 0.44506*height), control2: CGPoint(x: 0.54574*width, y: 0.45951*height))
                    path.addCurve(to: CGPoint(x: 0.53988*width, y: 0.47049*height), control1: CGPoint(x: 0.54255*width, y: 0.46356*height), control2: CGPoint(x: 0.54063*width, y: 0.46613*height))
                    path.addCurve(to: CGPoint(x: 0.53856*width, y: 0.47651*height), control1: CGPoint(x: 0.53951*width, y: 0.47255*height), control2: CGPoint(x: 0.53924*width, y: 0.47448*height))
                    path.addCurve(to: CGPoint(x: 0.5225*width, y: 0.51738*height), control1: CGPoint(x: 0.53405*width, y: 0.49065*height), control2: CGPoint(x: 0.53012*width, y: 0.50377*height))
                    path.addCurve(to: CGPoint(x: 0.51093*width, y: 0.53582*height), control1: CGPoint(x: 0.519*width, y: 0.52363*height), control2: CGPoint(x: 0.51433*width, y: 0.52954*height))
                    path.addCurve(to: CGPoint(x: 0.50366*width, y: 0.5586*height), control1: CGPoint(x: 0.50708*width, y: 0.54287*height), control2: CGPoint(x: 0.50546*width, y: 0.55123*height))
                    path.addCurve(to: CGPoint(x: 0.50051*width, y: 0.58091*height), control1: CGPoint(x: 0.50187*width, y: 0.566*height), control2: CGPoint(x: 0.50088*width, y: 0.57344*height))
                    return path
                }
            }
        }

        struct Biceps: Shape {
            func path(in rect: CGRect) -> Path {
                var path = Path()
                path.addPath(BicepsBrachii().path(in: rect))
                path.addPath(Brachialis().path(in: rect))
                return path.offsetBy(dx: 0.04675 * rect.size.width, dy: 0)
            }

            struct BicepsBrachii: Shape {
                func path(in rect: CGRect) -> Path {
                    var path = Path()
                    let width = rect.size.width
                    let height = rect.size.height
                    path.move(to: CGPoint(x: 0.55711*width, y: 0.30326*height))
                    path.addCurve(to: CGPoint(x: 0.57947*width, y: 0.36327*height), control1: CGPoint(x: 0.55581*width, y: 0.32313*height), control2: CGPoint(x: 0.57773*width, y: 0.35877*height))
                    path.addCurve(to: CGPoint(x: 0.58877*width, y: 0.3766*height), control1: CGPoint(x: 0.57947*width, y: 0.36327*height), control2: CGPoint(x: 0.58507*width, y: 0.37242*height))
                    path.addCurve(to: CGPoint(x: 0.60944*width, y: 0.39327*height), control1: CGPoint(x: 0.59424*width, y: 0.38281*height), control2: CGPoint(x: 0.60125*width, y: 0.38835*height))
                    path.addCurve(to: CGPoint(x: 0.61236*width, y: 0.31446*height), control1: CGPoint(x: 0.62331*width, y: 0.36901*height), control2: CGPoint(x: 0.62898*width, y: 0.33809*height))
                    path.addCurve(to: CGPoint(x: 0.56961*width, y: 0.29076*height), control1: CGPoint(x: 0.59377*width, y: 0.31073*height), control2: CGPoint(x: 0.57854*width, y: 0.30235*height))
                    path.addCurve(to: CGPoint(x: 0.55711*width, y: 0.30326*height), control1: CGPoint(x: 0.5659*width, y: 0.29478*height), control2: CGPoint(x: 0.56153*width, y: 0.29955*height))
                    path.move(to: CGPoint(x: 0.34838*width, y: 0.30349*height))
                    path.addCurve(to: CGPoint(x: 0.32602*width, y: 0.3635*height), control1: CGPoint(x: 0.34968*width, y: 0.32336*height), control2: CGPoint(x: 0.32775*width, y: 0.359*height))
                    path.addCurve(to: CGPoint(x: 0.31671*width, y: 0.37684*height), control1: CGPoint(x: 0.32602*width, y: 0.3635*height), control2: CGPoint(x: 0.32042*width, y: 0.37265*height))
                    path.addCurve(to: CGPoint(x: 0.29618*width, y: 0.39372*height), control1: CGPoint(x: 0.31125*width, y: 0.38304*height), control2: CGPoint(x: 0.30435*width, y: 0.3888*height))
                    path.addCurve(to: CGPoint(x: 0.29312*width, y: 0.31468*height), control1: CGPoint(x: 0.28231*width, y: 0.36946*height), control2: CGPoint(x: 0.2765*width, y: 0.33832*height))
                    path.addCurve(to: CGPoint(x: 0.33588*width, y: 0.29097*height), control1: CGPoint(x: 0.31171*width, y: 0.31094*height), control2: CGPoint(x: 0.32694*width, y: 0.30256*height))
                    path.addCurve(to: CGPoint(x: 0.34838*width, y: 0.30349*height), control1: CGPoint(x: 0.33958*width, y: 0.295*height), control2: CGPoint(x: 0.34398*width, y: 0.29977*height))
                    return path.offsetBy(dx: 0.0005*width, dy: 0)
                }
            }

            struct Brachialis: Shape {
                func path(in rect: CGRect) -> Path {
                    var path = Path()
                    let width = rect.size.width
                    let height = rect.size.height
                    path.move(to: CGPoint(x: 0.29634*width, y: 0.39397*height))
                    path.addLine(to: CGPoint(x: 0.29581*width, y: 0.39455*height))
                    path.addCurve(to: CGPoint(x: 0.27597*width, y: 0.35989*height), control1: CGPoint(x: 0.28625*width, y: 0.38352*height), control2: CGPoint(x: 0.27435*width, y: 0.37312*height))
                    path.addCurve(to: CGPoint(x: 0.27602*width, y: 0.35943*height), control1: CGPoint(x: 0.27597*width, y: 0.35974*height), control2: CGPoint(x: 0.276*width, y: 0.35958*height))
                    path.addCurve(to: CGPoint(x: 0.27609*width, y: 0.35895*height), control1: CGPoint(x: 0.27604*width, y: 0.35927*height), control2: CGPoint(x: 0.27606*width, y: 0.35912*height))
                    path.addLine(to: CGPoint(x: 0.27606*width, y: 0.35883*height))
                    path.addLine(to: CGPoint(x: 0.27606*width, y: 0.35881*height))
                    path.addCurve(to: CGPoint(x: 0.28049*width, y: 0.32965*height), control1: CGPoint(x: 0.27641*width, y: 0.35481*height), control2: CGPoint(x: 0.27799*width, y: 0.33773*height))
                    path.addCurve(to: CGPoint(x: 0.28822*width, y: 0.31221*height), control1: CGPoint(x: 0.28287*width, y: 0.32194*height), control2: CGPoint(x: 0.28694*width, y: 0.3144*height))
                    path.addCurve(to: CGPoint(x: 0.29227*width, y: 0.31583*height), control1: CGPoint(x: 0.28954*width, y: 0.3134*height), control2: CGPoint(x: 0.29095*width, y: 0.31466*height))
                    path.addLine(to: CGPoint(x: 0.29238*width, y: 0.316*height))
                    path.addCurve(to: CGPoint(x: 0.29593*width, y: 0.39321*height), control1: CGPoint(x: 0.27597*width, y: 0.33988*height), control2: CGPoint(x: 0.2819*width, y: 0.36889*height))
                    path.addLine(to: CGPoint(x: 0.29634*width, y: 0.39397*height))
                    path.closeSubpath()
                    path.move(to: CGPoint(x: 0.61016*width, y: 0.39373*height))
                    path.addCurve(to: CGPoint(x: 0.61414*width, y: 0.31508*height), control1: CGPoint(x: 0.62419*width, y: 0.36943*height), control2: CGPoint(x: 0.63056*width, y: 0.33895*height))
                    path.addLine(to: CGPoint(x: 0.61428*width, y: 0.31497*height))
                    path.addCurve(to: CGPoint(x: 0.61826*width, y: 0.31142*height), control1: CGPoint(x: 0.6156*width, y: 0.3138*height), control2: CGPoint(x: 0.61694*width, y: 0.31261*height))
                    path.addCurve(to: CGPoint(x: 0.6263*width, y: 0.32965*height), control1: CGPoint(x: 0.61954*width, y: 0.31361*height), control2: CGPoint(x: 0.62391*width, y: 0.32194*height))
                    path.addCurve(to: CGPoint(x: 0.63072*width, y: 0.35881*height), control1: CGPoint(x: 0.6288*width, y: 0.33773*height), control2: CGPoint(x: 0.63037*width, y: 0.35481*height))
                    path.addLine(to: CGPoint(x: 0.63072*width, y: 0.35883*height))
                    path.addLine(to: CGPoint(x: 0.63069*width, y: 0.35895*height))
                    path.addCurve(to: CGPoint(x: 0.63076*width, y: 0.35943*height), control1: CGPoint(x: 0.63072*width, y: 0.35912*height), control2: CGPoint(x: 0.63074*width, y: 0.35927*height))
                    path.addCurve(to: CGPoint(x: 0.63081*width, y: 0.35989*height), control1: CGPoint(x: 0.63079*width, y: 0.35958*height), control2: CGPoint(x: 0.63081*width, y: 0.35974*height))
                    path.addCurve(to: CGPoint(x: 0.61097*width, y: 0.39455*height), control1: CGPoint(x: 0.63241*width, y: 0.37312*height), control2: CGPoint(x: 0.62053*width, y: 0.38353*height))
                    path.addLine(to: CGPoint(x: 0.61009*width, y: 0.39409*height))
                    path.addLine(to: CGPoint(x: 0.61016*width, y: 0.39373*height))
                    path.closeSubpath()
                    return path
                }
            }
        }

        struct Calves: Shape {
            func path(in rect: CGRect) -> Path {
                var path = Path()
                path.addPath(Grastrocnemius().path(in: rect))
                path.addPath(PeroneusLongus().path(in: rect))
                path.addPath(Soleus().path(in: rect))
                return path
                    .offsetBy(dx: 0.0072*rect.size.width, dy: 0)
            }

            struct Grastrocnemius: Shape {
                func path(in rect: CGRect) -> Path {
                    var path = Path()
                    let width = rect.size.width
                    let height = rect.size.height
                    path.move(to: CGPoint(x: 0.4306*width, y: 0.72633*height))
                    path.addCurve(to: CGPoint(x: 0.41706*width, y: 0.74861*height), control1: CGPoint(x: 0.42646*width, y: 0.73549*height), control2: CGPoint(x: 0.42125*width, y: 0.74276*height))
                    path.addCurve(to: CGPoint(x: 0.41086*width, y: 0.75798*height), control1: CGPoint(x: 0.41456*width, y: 0.75213*height), control2: CGPoint(x: 0.41238*width, y: 0.75517*height))
                    path.addCurve(to: CGPoint(x: 0.40861*width, y: 0.76284*height), control1: CGPoint(x: 0.41028*width, y: 0.75904*height), control2: CGPoint(x: 0.40951*width, y: 0.76073*height))
                    path.addCurve(to: CGPoint(x: 0.38836*width, y: 0.74056*height), control1: CGPoint(x: 0.39502*width, y: 0.75849*height), control2: CGPoint(x: 0.38988*width, y: 0.74981*height))
                    path.addLine(to: CGPoint(x: 0.38836*width, y: 0.74049*height))
                    path.addCurve(to: CGPoint(x: 0.38894*width, y: 0.73497*height), control1: CGPoint(x: 0.38859*width, y: 0.7387*height), control2: CGPoint(x: 0.38875*width, y: 0.73688*height))
                    path.addCurve(to: CGPoint(x: 0.39306*width, y: 0.71435*height), control1: CGPoint(x: 0.38954*width, y: 0.72806*height), control2: CGPoint(x: 0.38981*width, y: 0.72099*height))
                    path.addCurve(to: CGPoint(x: 0.40377*width, y: 0.70029*height), control1: CGPoint(x: 0.39549*width, y: 0.70934*height), control2: CGPoint(x: 0.39931*width, y: 0.70463*height))
                    path.addCurve(to: CGPoint(x: 0.41856*width, y: 0.68789*height), control1: CGPoint(x: 0.40829*width, y: 0.69593*height), control2: CGPoint(x: 0.41389*width, y: 0.69216*height))
                    path.addCurve(to: CGPoint(x: 0.42623*width, y: 0.68015*height), control1: CGPoint(x: 0.42127*width, y: 0.6854*height), control2: CGPoint(x: 0.42384*width, y: 0.68281*height))
                    path.addCurve(to: CGPoint(x: 0.4306*width, y: 0.72633*height), control1: CGPoint(x: 0.42854*width, y: 0.68776*height), control2: CGPoint(x: 0.43606*width, y: 0.71418*height))
                    path.move(to: CGPoint(x: 0.51171*width, y: 0.72608*height))
                    path.addCurve(to: CGPoint(x: 0.52532*width, y: 0.74836*height), control1: CGPoint(x: 0.51588*width, y: 0.73525*height), control2: CGPoint(x: 0.52111*width, y: 0.74252*height))
                    path.addCurve(to: CGPoint(x: 0.53157*width, y: 0.75773*height), control1: CGPoint(x: 0.52785*width, y: 0.75188*height), control2: CGPoint(x: 0.53002*width, y: 0.75492*height))
                    path.addCurve(to: CGPoint(x: 0.53384*width, y: 0.76259*height), control1: CGPoint(x: 0.53215*width, y: 0.7588*height), control2: CGPoint(x: 0.53292*width, y: 0.76048*height))
                    path.addCurve(to: CGPoint(x: 0.55419*width, y: 0.74031*height), control1: CGPoint(x: 0.5475*width, y: 0.75824*height), control2: CGPoint(x: 0.55266*width, y: 0.74957*height))
                    path.addLine(to: CGPoint(x: 0.55419*width, y: 0.74025*height))
                    path.addCurve(to: CGPoint(x: 0.55361*width, y: 0.73472*height), control1: CGPoint(x: 0.55396*width, y: 0.73846*height), control2: CGPoint(x: 0.5538*width, y: 0.73664*height))
                    path.addCurve(to: CGPoint(x: 0.54947*width, y: 0.7141*height), control1: CGPoint(x: 0.55301*width, y: 0.72781*height), control2: CGPoint(x: 0.55273*width, y: 0.72074*height))
                    path.addCurve(to: CGPoint(x: 0.5387*width, y: 0.70005*height), control1: CGPoint(x: 0.54701*width, y: 0.70909*height), control2: CGPoint(x: 0.54319*width, y: 0.70438*height))
                    path.addCurve(to: CGPoint(x: 0.52384*width, y: 0.68764*height), control1: CGPoint(x: 0.53417*width, y: 0.69568*height), control2: CGPoint(x: 0.52854*width, y: 0.69191*height))
                    path.addCurve(to: CGPoint(x: 0.51613*width, y: 0.67991*height), control1: CGPoint(x: 0.52111*width, y: 0.68515*height), control2: CGPoint(x: 0.51854*width, y: 0.68256*height))
                    path.addCurve(to: CGPoint(x: 0.51171*width, y: 0.72608*height), control1: CGPoint(x: 0.51377*width, y: 0.6875*height), control2: CGPoint(x: 0.50623*width, y: 0.71392*height))
                    return path.offsetBy(dx: width * 0.0215, dy: 0)
                }
            }

            struct PeroneusLongus: Shape {
                func path(in rect: CGRect) -> Path {
                    var path = Path()
                    let width = rect.size.width
                    let height = rect.size.height
                    path.move(to: CGPoint(x: 0.37947*width, y: 0.68207*height))
                    path.addCurve(to: CGPoint(x: 0.37674*width, y: 0.67767*height), control1: CGPoint(x: 0.37898*width, y: 0.67986*height), control2: CGPoint(x: 0.37775*width, y: 0.67887*height))
                    path.addCurve(to: CGPoint(x: 0.3603*width, y: 0.71685*height), control1: CGPoint(x: 0.37275*width, y: 0.68403*height), control2: CGPoint(x: 0.36062*width, y: 0.70417*height))
                    path.addCurve(to: CGPoint(x: 0.36736*width, y: 0.75762*height), control1: CGPoint(x: 0.36012*width, y: 0.72409*height), control2: CGPoint(x: 0.36363*width, y: 0.74037*height))
                    path.addCurve(to: CGPoint(x: 0.3756*width, y: 0.8059*height), control1: CGPoint(x: 0.37162*width, y: 0.77725*height), control2: CGPoint(x: 0.37648*width, y: 0.79758*height))
                    path.addCurve(to: CGPoint(x: 0.37565*width, y: 0.80907*height), control1: CGPoint(x: 0.37551*width, y: 0.80691*height), control2: CGPoint(x: 0.37581*width, y: 0.80819*height))
                    path.addCurve(to: CGPoint(x: 0.38241*width, y: 0.80122*height), control1: CGPoint(x: 0.38*width, y: 0.8046*height), control2: CGPoint(x: 0.38208*width, y: 0.80275*height))
                    path.addCurve(to: CGPoint(x: 0.37947*width, y: 0.68207*height), control1: CGPoint(x: 0.36574*width, y: 0.75194*height), control2: CGPoint(x: 0.36303*width, y: 0.70613*height))
                    path.closeSubpath()
                    path.move(to: CGPoint(x: 0.59609*width, y: 0.68252*height))
                    path.addCurve(to: CGPoint(x: 0.59882*width, y: 0.67812*height), control1: CGPoint(x: 0.59657*width, y: 0.68031*height), control2: CGPoint(x: 0.5978*width, y: 0.67932*height))
                    path.addCurve(to: CGPoint(x: 0.61525*width, y: 0.7173*height), control1: CGPoint(x: 0.6028*width, y: 0.68448*height), control2: CGPoint(x: 0.61493*width, y: 0.70461*height))
                    path.addCurve(to: CGPoint(x: 0.60819*width, y: 0.75807*height), control1: CGPoint(x: 0.61544*width, y: 0.72454*height), control2: CGPoint(x: 0.61192*width, y: 0.74082*height))
                    path.addCurve(to: CGPoint(x: 0.59995*width, y: 0.80634*height), control1: CGPoint(x: 0.60394*width, y: 0.7777*height), control2: CGPoint(x: 0.59907*width, y: 0.79802*height))
                    path.addCurve(to: CGPoint(x: 0.59991*width, y: 0.80952*height), control1: CGPoint(x: 0.60005*width, y: 0.80736*height), control2: CGPoint(x: 0.59975*width, y: 0.80864*height))
                    path.addCurve(to: CGPoint(x: 0.59315*width, y: 0.80167*height), control1: CGPoint(x: 0.59556*width, y: 0.80505*height), control2: CGPoint(x: 0.59347*width, y: 0.80319*height))
                    path.addCurve(to: CGPoint(x: 0.59609*width, y: 0.68252*height), control1: CGPoint(x: 0.60984*width, y: 0.75241*height), control2: CGPoint(x: 0.61255*width, y: 0.70657*height))
                    path.closeSubpath()
                    return path
                        .offsetBy(dx: 0.005*width, dy: 0)
                }
            }

            struct Soleus: Shape {
                func path(in rect: CGRect) -> Path {
                    var path = Path()
                    let width = rect.size.width
                    let height = rect.size.height
                    path.move(to: CGPoint(x: 0.56137*width, y: 0.78455*height))
                    path.addCurve(to: CGPoint(x: 0.56766*width, y: 0.81216*height), control1: CGPoint(x: 0.56542*width, y: 0.79671*height), control2: CGPoint(x: 0.56884*width, y: 0.80801*height))
                    path.addCurve(to: CGPoint(x: 0.56713*width, y: 0.81554*height), control1: CGPoint(x: 0.5675*width, y: 0.81276*height), control2: CGPoint(x: 0.5678*width, y: 0.81517*height))
                    path.addCurve(to: CGPoint(x: 0.57836*width, y: 0.78772*height), control1: CGPoint(x: 0.57826*width, y: 0.80934*height), control2: CGPoint(x: 0.57831*width, y: 0.79696*height))
                    path.addCurve(to: CGPoint(x: 0.5784*width, y: 0.78378*height), control1: CGPoint(x: 0.57838*width, y: 0.78636*height), control2: CGPoint(x: 0.57838*width, y: 0.78505*height))
                    path.addCurve(to: CGPoint(x: 0.57729*width, y: 0.74843*height), control1: CGPoint(x: 0.57863*width, y: 0.77546*height), control2: CGPoint(x: 0.57903*width, y: 0.75645*height))
                    path.addCurve(to: CGPoint(x: 0.55597*width, y: 0.76728*height), control1: CGPoint(x: 0.56856*width, y: 0.76233*height), control2: CGPoint(x: 0.56613*width, y: 0.76194*height))
                    path.addLine(to: CGPoint(x: 0.5612*width, y: 0.78265*height))
                    path.addLine(to: CGPoint(x: 0.56137*width, y: 0.78455*height))
                    path.closeSubpath()
                    path.move(to: CGPoint(x: 0.42412*width, y: 0.78466*height))
                    path.addCurve(to: CGPoint(x: 0.41782*width, y: 0.81227*height), control1: CGPoint(x: 0.42007*width, y: 0.79682*height), control2: CGPoint(x: 0.41664*width, y: 0.80812*height))
                    path.addCurve(to: CGPoint(x: 0.41836*width, y: 0.81565*height), control1: CGPoint(x: 0.41799*width, y: 0.81287*height), control2: CGPoint(x: 0.41769*width, y: 0.81528*height))
                    path.addCurve(to: CGPoint(x: 0.40713*width, y: 0.78782*height), control1: CGPoint(x: 0.40722*width, y: 0.80944*height), control2: CGPoint(x: 0.40718*width, y: 0.79707*height))
                    path.addCurve(to: CGPoint(x: 0.40708*width, y: 0.78389*height), control1: CGPoint(x: 0.40711*width, y: 0.78647*height), control2: CGPoint(x: 0.40711*width, y: 0.78515*height))
                    path.addCurve(to: CGPoint(x: 0.40819*width, y: 0.74853*height), control1: CGPoint(x: 0.40685*width, y: 0.77557*height), control2: CGPoint(x: 0.40646*width, y: 0.75656*height))
                    path.addCurve(to: CGPoint(x: 0.42951*width, y: 0.76739*height), control1: CGPoint(x: 0.41692*width, y: 0.76244*height), control2: CGPoint(x: 0.41935*width, y: 0.76205*height))
                    path.addLine(to: CGPoint(x: 0.42428*width, y: 0.78276*height))
                    path.addLine(to: CGPoint(x: 0.42412*width, y: 0.78466*height))
                    path.closeSubpath()
                    return path
                }
            }
        }

        struct Forearms: Shape {
            func path(in rect: CGRect) -> Path {
                var path = Path()
                path.addPath(Brachioradialis().path(in: rect))
                path.addPath(ExtensorCarpiRadialis().path(in: rect))
                path.addPath(FlexorCarpiRadialis().path(in: rect))
                return path.offsetBy(dx: 0.04675*rect.size.width, dy: 0)
            }

            struct Brachioradialis: Shape {
                func path(in rect: CGRect) -> Path {
                    var path = Path()
                    let width = rect.size.width
                    let height = rect.size.height
                    path.move(to: CGPoint(x: 0.60898*width, y: 0.45551*height))
                    path.addLine(to: CGPoint(x: 0.609*width, y: 0.45554*height))
                    path.addCurve(to: CGPoint(x: 0.61535*width, y: 0.47071*height), control1: CGPoint(x: 0.61218*width, y: 0.46153*height), control2: CGPoint(x: 0.61463*width, y: 0.46684*height))
                    path.addCurve(to: CGPoint(x: 0.61569*width, y: 0.47259*height), control1: CGPoint(x: 0.61549*width, y: 0.47137*height), control2: CGPoint(x: 0.61558*width, y: 0.47199*height))
                    path.addCurve(to: CGPoint(x: 0.62616*width, y: 0.44444*height), control1: CGPoint(x: 0.61736*width, y: 0.46298*height), control2: CGPoint(x: 0.62116*width, y: 0.45372*height))
                    path.addCurve(to: CGPoint(x: 0.65002*width, y: 0.39875*height), control1: CGPoint(x: 0.63435*width, y: 0.42924*height), control2: CGPoint(x: 0.64722*width, y: 0.41498*height))
                    path.addLine(to: CGPoint(x: 0.64998*width, y: 0.38535*height))
                    path.addCurve(to: CGPoint(x: 0.63463*width, y: 0.35894*height), control1: CGPoint(x: 0.64998*width, y: 0.37468*height), control2: CGPoint(x: 0.63863*width, y: 0.36298*height))
                    path.addCurve(to: CGPoint(x: 0.60968*width, y: 0.39824*height), control1: CGPoint(x: 0.63521*width, y: 0.37373*height), control2: CGPoint(x: 0.61947*width, y: 0.3854*height))
                    path.addCurve(to: CGPoint(x: 0.60898*width, y: 0.45551*height), control1: CGPoint(x: 0.59609*width, y: 0.41611*height), control2: CGPoint(x: 0.60194*width, y: 0.43676*height))
                    path.move(to: CGPoint(x: 0.29435*width, y: 0.47397*height))
                    path.addCurve(to: CGPoint(x: 0.28444*width, y: 0.445*height), control1: CGPoint(x: 0.29269*width, y: 0.46435*height), control2: CGPoint(x: 0.28944*width, y: 0.45427*height))
                    path.addCurve(to: CGPoint(x: 0.26072*width, y: 0.39975*height), control1: CGPoint(x: 0.27625*width, y: 0.4298*height), control2: CGPoint(x: 0.26352*width, y: 0.41599*height))
                    path.addLine(to: CGPoint(x: 0.26072*width, y: 0.38631*height))
                    path.addCurve(to: CGPoint(x: 0.27586*width, y: 0.35852*height), control1: CGPoint(x: 0.26072*width, y: 0.37563*height), control2: CGPoint(x: 0.27187*width, y: 0.36256*height))
                    path.addCurve(to: CGPoint(x: 0.3015*width, y: 0.39802*height), control1: CGPoint(x: 0.27528*width, y: 0.37332*height), control2: CGPoint(x: 0.29174*width, y: 0.3852*height))
                    path.addCurve(to: CGPoint(x: 0.30174*width, y: 0.45656*height), control1: CGPoint(x: 0.31512*width, y: 0.4159*height), control2: CGPoint(x: 0.3088*width, y: 0.43782*height))
                    path.addLine(to: CGPoint(x: 0.29435*width, y: 0.47397*height))
                    path.closeSubpath()
                    return path.offsetBy(dx: -0.0025*width, dy: 0)
                }
            }

            struct ExtensorCarpiRadialis: Shape {
                func path(in rect: CGRect) -> Path {
                    var path = Path()
                    let width = rect.size.width
                    let height = rect.size.height
                    path.move(to: CGPoint(x: 0.62475*width, y: 0.48877*height))
                    path.addCurve(to: CGPoint(x: 0.66403*width, y: 0.43648*height), control1: CGPoint(x: 0.64326*width, y: 0.47318*height), control2: CGPoint(x: 0.65905*width, y: 0.45623*height))
                    path.addLine(to: CGPoint(x: 0.66405*width, y: 0.43633*height))
                    path.addCurve(to: CGPoint(x: 0.66583*width, y: 0.4271*height), control1: CGPoint(x: 0.66454*width, y: 0.43335*height), control2: CGPoint(x: 0.66553*width, y: 0.43023*height))
                    path.addCurve(to: CGPoint(x: 0.6594*width, y: 0.40148*height), control1: CGPoint(x: 0.66711*width, y: 0.41318*height), control2: CGPoint(x: 0.66155*width, y: 0.40432*height))
                    path.addCurve(to: CGPoint(x: 0.64234*width, y: 0.43574*height), control1: CGPoint(x: 0.65697*width, y: 0.4133*height), control2: CGPoint(x: 0.64956*width, y: 0.42485*height))
                    path.addCurve(to: CGPoint(x: 0.62523*width, y: 0.48012*height), control1: CGPoint(x: 0.63285*width, y: 0.45008*height), control2: CGPoint(x: 0.62687*width, y: 0.46471*height))
                    path.addCurve(to: CGPoint(x: 0.62479*width, y: 0.48656*height), control1: CGPoint(x: 0.62537*width, y: 0.48259*height), control2: CGPoint(x: 0.62523*width, y: 0.48466*height))
                    path.addLine(to: CGPoint(x: 0.62479*width, y: 0.48657*height))
                    path.addLine(to: CGPoint(x: 0.62479*width, y: 0.4866*height))
                    path.addCurve(to: CGPoint(x: 0.62475*width, y: 0.48877*height), control1: CGPoint(x: 0.62477*width, y: 0.48733*height), control2: CGPoint(x: 0.62475*width, y: 0.48804*height))
                    path.move(to: CGPoint(x: 0.30389*width, y: 0.48877*height))
                    path.addCurve(to: CGPoint(x: 0.26461*width, y: 0.43648*height), control1: CGPoint(x: 0.28537*width, y: 0.47318*height), control2: CGPoint(x: 0.26958*width, y: 0.45623*height))
                    path.addLine(to: CGPoint(x: 0.26458*width, y: 0.43633*height))
                    path.addCurve(to: CGPoint(x: 0.26343*width, y: 0.42722*height), control1: CGPoint(x: 0.2641*width, y: 0.43335*height), control2: CGPoint(x: 0.2637*width, y: 0.43034*height))
                    path.addCurve(to: CGPoint(x: 0.26919*width, y: 0.40167*height), control1: CGPoint(x: 0.26215*width, y: 0.4133*height), control2: CGPoint(x: 0.26704*width, y: 0.40452*height))
                    path.addCurve(to: CGPoint(x: 0.28632*width, y: 0.43574*height), control1: CGPoint(x: 0.27162*width, y: 0.41349*height), control2: CGPoint(x: 0.2791*width, y: 0.42486*height))
                    path.addCurve(to: CGPoint(x: 0.30343*width, y: 0.48012*height), control1: CGPoint(x: 0.29581*width, y: 0.45008*height), control2: CGPoint(x: 0.30178*width, y: 0.46471*height))
                    path.addCurve(to: CGPoint(x: 0.30387*width, y: 0.48656*height), control1: CGPoint(x: 0.30329*width, y: 0.48259*height), control2: CGPoint(x: 0.30343*width, y: 0.48466*height))
                    path.addLine(to: CGPoint(x: 0.30387*width, y: 0.48657*height))
                    path.addLine(to: CGPoint(x: 0.30387*width, y: 0.4866*height))
                    path.addCurve(to: CGPoint(x: 0.30389*width, y: 0.48877*height), control1: CGPoint(x: 0.30387*width, y: 0.48733*height), control2: CGPoint(x: 0.30389*width, y: 0.48804*height))
                    return path.offsetBy(dx: -0.0115*width, dy: 0)
                }
            }

            struct FlexorCarpiRadialis: Shape {
                func path(in rect: CGRect) -> Path {
                    var path = Path()
                    let width = rect.size.width
                    let height = rect.size.height
                    path.move(to: CGPoint(x: 0.31426*width, y: 0.4131*height))
                    path.addCurve(to: CGPoint(x: 0.3115*width, y: 0.39619*height), control1: CGPoint(x: 0.31493*width, y: 0.40259*height), control2: CGPoint(x: 0.31227*width, y: 0.39779*height))
                    path.addCurve(to: CGPoint(x: 0.29755*width, y: 0.405*height), control1: CGPoint(x: 0.30632*width, y: 0.39877*height), control2: CGPoint(x: 0.30167*width, y: 0.40171*height))
                    path.addCurve(to: CGPoint(x: 0.29894*width, y: 0.41049*height), control1: CGPoint(x: 0.29829*width, y: 0.40644*height), control2: CGPoint(x: 0.29847*width, y: 0.40901*height))
                    path.addCurve(to: CGPoint(x: 0.29683*width, y: 0.4498*height), control1: CGPoint(x: 0.30315*width, y: 0.42378*height), control2: CGPoint(x: 0.30097*width, y: 0.43684*height))
                    path.addCurve(to: CGPoint(x: 0.29907*width, y: 0.44583*height), control1: CGPoint(x: 0.29757*width, y: 0.44849*height), control2: CGPoint(x: 0.29831*width, y: 0.44716*height))
                    path.addCurve(to: CGPoint(x: 0.31407*width, y: 0.41432*height), control1: CGPoint(x: 0.30579*width, y: 0.43398*height), control2: CGPoint(x: 0.31363*width, y: 0.42123*height))
                    path.addLine(to: CGPoint(x: 0.31426*width, y: 0.4131*height))
                    path.closeSubpath()
                    path.move(to: CGPoint(x: 0.5784*width, y: 0.41275*height))
                    path.addCurve(to: CGPoint(x: 0.58174*width, y: 0.39585*height), control1: CGPoint(x: 0.57773*width, y: 0.40224*height), control2: CGPoint(x: 0.581*width, y: 0.39745*height))
                    path.addCurve(to: CGPoint(x: 0.59611*width, y: 0.40488*height), control1: CGPoint(x: 0.58692*width, y: 0.39843*height), control2: CGPoint(x: 0.59199*width, y: 0.40159*height))
                    path.addCurve(to: CGPoint(x: 0.59405*width, y: 0.40969*height), control1: CGPoint(x: 0.59537*width, y: 0.40631*height), control2: CGPoint(x: 0.59451*width, y: 0.40821*height))
                    path.addCurve(to: CGPoint(x: 0.5966*width, y: 0.45002*height), control1: CGPoint(x: 0.58984*width, y: 0.42298*height), control2: CGPoint(x: 0.59245*width, y: 0.43705*height))
                    path.addCurve(to: CGPoint(x: 0.59345*width, y: 0.44571*height), control1: CGPoint(x: 0.59586*width, y: 0.4487*height), control2: CGPoint(x: 0.59424*width, y: 0.44704*height))
                    path.addCurve(to: CGPoint(x: 0.57843*width, y: 0.41414*height), control1: CGPoint(x: 0.58674*width, y: 0.43386*height), control2: CGPoint(x: 0.57887*width, y: 0.42105*height))
                    path.addLine(to: CGPoint(x: 0.5784*width, y: 0.41275*height))
                    path.closeSubpath()
                    return path.offsetBy(dx: 0.0065*width, dy: 0)
                }
            }
        }

        struct Neck: Shape {
            func path(in rect: CGRect) -> Path {
                var path = Path()
                path.addPath(Omohyoid().path(in: rect))
                path.addPath(Sternocleidomastoid().path(in: rect))
                return path.offsetBy(dx: 0.04675 * rect.size.width, dy: 0)
            }

            struct Omohyoid: Shape {
                func path(in rect: CGRect) -> Path {
                    var path = Path()
                    let width = rect.size.width
                    let height = rect.size.height
                    path.move(to: CGPoint(x: 0.46986*width, y: 0.24485*height))
                    path.addCurve(to: CGPoint(x: 0.47891*width, y: 0.22977*height), control1: CGPoint(x: 0.47266*width, y: 0.24006*height), control2: CGPoint(x: 0.4762*width, y: 0.23427*height))
                    path.addCurve(to: CGPoint(x: 0.51208*width, y: 0.24679*height), control1: CGPoint(x: 0.48419*width, y: 0.23881*height), control2: CGPoint(x: 0.49769*width, y: 0.24559*height))
                    path.addCurve(to: CGPoint(x: 0.47009*width, y: 0.24549*height), control1: CGPoint(x: 0.49799*width, y: 0.24951*height), control2: CGPoint(x: 0.48183*width, y: 0.25153*height))
                    path.addLine(to: CGPoint(x: 0.46986*width, y: 0.24485*height))
                    path.closeSubpath()
                    path.move(to: CGPoint(x: 0.43574*width, y: 0.24492*height))
                    path.addCurve(to: CGPoint(x: 0.42683*width, y: 0.22988*height), control1: CGPoint(x: 0.43294*width, y: 0.24014*height), control2: CGPoint(x: 0.42951*width, y: 0.23437*height))
                    path.addCurve(to: CGPoint(x: 0.39516*width, y: 0.24708*height), control1: CGPoint(x: 0.42155*width, y: 0.23892*height), control2: CGPoint(x: 0.40956*width, y: 0.2459*height))
                    path.addCurve(to: CGPoint(x: 0.43586*width, y: 0.24557*height), control1: CGPoint(x: 0.40926*width, y: 0.2498*height), control2: CGPoint(x: 0.42576*width, y: 0.25102*height))
                    path.addLine(to: CGPoint(x: 0.43574*width, y: 0.24492*height))
                    path.closeSubpath()
                    path.move(to: CGPoint(x: 0.47963*width, y: 0.22929*height))
                    path.addLine(to: CGPoint(x: 0.47963*width, y: 0.22931*height))
                    path.addCurve(to: CGPoint(x: 0.51414*width, y: 0.24617*height), control1: CGPoint(x: 0.48477*width, y: 0.23938*height), control2: CGPoint(x: 0.49803*width, y: 0.24585*height))
                    path.addCurve(to: CGPoint(x: 0.52926*width, y: 0.24228*height), control1: CGPoint(x: 0.51919*width, y: 0.24509*height), control2: CGPoint(x: 0.52523*width, y: 0.24344*height))
                    path.addCurve(to: CGPoint(x: 0.52088*width, y: 0.24035*height), control1: CGPoint(x: 0.52655*width, y: 0.24194*height), control2: CGPoint(x: 0.52354*width, y: 0.24127*height))
                    path.addCurve(to: CGPoint(x: 0.48819*width, y: 0.21105*height), control1: CGPoint(x: 0.50479*width, y: 0.23481*height), control2: CGPoint(x: 0.50132*width, y: 0.21887*height))
                    path.addCurve(to: CGPoint(x: 0.48405*width, y: 0.22191*height), control1: CGPoint(x: 0.48708*width, y: 0.21475*height), control2: CGPoint(x: 0.48572*width, y: 0.21924*height))
                    path.addCurve(to: CGPoint(x: 0.47963*width, y: 0.22929*height), control1: CGPoint(x: 0.48303*width, y: 0.2236*height), control2: CGPoint(x: 0.48146*width, y: 0.2262*height))
                    path.move(to: CGPoint(x: 0.42625*width, y: 0.22873*height))
                    path.addCurve(to: CGPoint(x: 0.42194*width, y: 0.22157*height), control1: CGPoint(x: 0.42442*width, y: 0.22565*height), control2: CGPoint(x: 0.42299*width, y: 0.22324*height))
                    path.addCurve(to: CGPoint(x: 0.41778*width, y: 0.21133*height), control1: CGPoint(x: 0.42028*width, y: 0.2189*height), control2: CGPoint(x: 0.41891*width, y: 0.21505*height))
                    path.addCurve(to: CGPoint(x: 0.38491*width, y: 0.24091*height), control1: CGPoint(x: 0.40465*width, y: 0.21917*height), control2: CGPoint(x: 0.401*width, y: 0.23537*height))
                    path.addCurve(to: CGPoint(x: 0.37685*width, y: 0.24278*height), control1: CGPoint(x: 0.38225*width, y: 0.24182*height), control2: CGPoint(x: 0.37958*width, y: 0.24242*height))
                    path.addCurve(to: CGPoint(x: 0.39132*width, y: 0.24677*height), control1: CGPoint(x: 0.38088*width, y: 0.24394*height), control2: CGPoint(x: 0.38627*width, y: 0.24569*height))
                    path.addCurve(to: CGPoint(x: 0.42644*width, y: 0.22918*height), control1: CGPoint(x: 0.40745*width, y: 0.24645*height), control2: CGPoint(x: 0.42127*width, y: 0.23926*height))
                    path.addLine(to: CGPoint(x: 0.42625*width, y: 0.22873*height))
                    path.closeSubpath()
                    return path
                }
            }

            struct Sternocleidomastoid: Shape {
                func path(in rect: CGRect) -> Path {
                    var path = Path()
                    let width = rect.size.width
                    let height = rect.size.height
                    path.move(to: CGPoint(x: 0.46141*width, y: 0.25809*height))
                    path.addCurve(to: CGPoint(x: 0.48273*width, y: 0.22117*height), control1: CGPoint(x: 0.46484*width, y: 0.25215*height), control2: CGPoint(x: 0.47845*width, y: 0.22807*height))
                    path.addCurve(to: CGPoint(x: 0.49067*width, y: 0.19599*height), control1: CGPoint(x: 0.48759*width, y: 0.21333*height), control2: CGPoint(x: 0.49067*width, y: 0.19613*height))
                    path.addLine(to: CGPoint(x: 0.49067*width, y: 0.19574*height))
                    path.addCurve(to: CGPoint(x: 0.4906*width, y: 0.19127*height), control1: CGPoint(x: 0.49046*width, y: 0.19441*height), control2: CGPoint(x: 0.49072*width, y: 0.19225*height))
                    path.addCurve(to: CGPoint(x: 0.48178*width, y: 0.19622*height), control1: CGPoint(x: 0.48875*width, y: 0.19261*height), control2: CGPoint(x: 0.48481*width, y: 0.19448*height))
                    path.addLine(to: CGPoint(x: 0.4813*width, y: 0.19704*height))
                    path.addCurve(to: CGPoint(x: 0.46785*width, y: 0.22247*height), control1: CGPoint(x: 0.47641*width, y: 0.2083*height), control2: CGPoint(x: 0.47174*width, y: 0.21617*height))
                    path.addCurve(to: CGPoint(x: 0.46125*width, y: 0.2342*height), control1: CGPoint(x: 0.46521*width, y: 0.22676*height), control2: CGPoint(x: 0.46289*width, y: 0.23048*height))
                    path.addCurve(to: CGPoint(x: 0.46049*width, y: 0.25451*height), control1: CGPoint(x: 0.45799*width, y: 0.24162*height), control2: CGPoint(x: 0.45958*width, y: 0.25056*height))
                    path.addLine(to: CGPoint(x: 0.46141*width, y: 0.25809*height))
                    path.closeSubpath()
                    path.move(to: CGPoint(x: 0.44361*width, y: 0.25634*height))
                    path.addCurve(to: CGPoint(x: 0.44294*width, y: 0.23441*height), control1: CGPoint(x: 0.44451*width, y: 0.25239*height), control2: CGPoint(x: 0.44623*width, y: 0.24184*height))
                    path.addCurve(to: CGPoint(x: 0.43632*width, y: 0.22241*height), control1: CGPoint(x: 0.4413*width, y: 0.23069*height), control2: CGPoint(x: 0.43896*width, y: 0.2267*height))
                    path.addCurve(to: CGPoint(x: 0.42292*width, y: 0.1975*height), control1: CGPoint(x: 0.43243*width, y: 0.21611*height), control2: CGPoint(x: 0.42778*width, y: 0.20877*height))
                    path.addLine(to: CGPoint(x: 0.42257*width, y: 0.19696*height))
                    path.addCurve(to: CGPoint(x: 0.41486*width, y: 0.19219*height), control1: CGPoint(x: 0.41954*width, y: 0.19523*height), control2: CGPoint(x: 0.41671*width, y: 0.19355*height))
                    path.addCurve(to: CGPoint(x: 0.41424*width, y: 0.196*height), control1: CGPoint(x: 0.41477*width, y: 0.19318*height), control2: CGPoint(x: 0.41444*width, y: 0.19468*height))
                    path.addLine(to: CGPoint(x: 0.41424*width, y: 0.19625*height))
                    path.addCurve(to: CGPoint(x: 0.42174*width, y: 0.22088*height), control1: CGPoint(x: 0.41424*width, y: 0.19639*height), control2: CGPoint(x: 0.41687*width, y: 0.21304*height))
                    path.addCurve(to: CGPoint(x: 0.44294*width, y: 0.25728*height), control1: CGPoint(x: 0.42602*width, y: 0.22776*height), control2: CGPoint(x: 0.43951*width, y: 0.25136*height))
                    path.addLine(to: CGPoint(x: 0.44361*width, y: 0.25634*height))
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
                return path.offsetBy(dx: 0.018 * rect.size.width, dy: 0)
            }

            struct ExternalObliques: Shape {
                func path(in rect: CGRect) -> Path {
                    var path = Path()
                    let width = rect.size.width
                    let height = rect.size.height
                    path.move(to: CGPoint(x: 0.42975*width, y: 0.43566*height))
                    path.addCurve(to: CGPoint(x: 0.41984*width, y: 0.44671*height), control1: CGPoint(x: 0.42856*width, y: 0.43958*height), control2: CGPoint(x: 0.42345*width, y: 0.44377*height))
                    path.addCurve(to: CGPoint(x: 0.40481*width, y: 0.44613*height), control1: CGPoint(x: 0.41479*width, y: 0.45082*height), control2: CGPoint(x: 0.41009*width, y: 0.44894*height))
                    path.addCurve(to: CGPoint(x: 0.39127*width, y: 0.43877*height), control1: CGPoint(x: 0.40019*width, y: 0.44372*height), control2: CGPoint(x: 0.39576*width, y: 0.44123*height))
                    path.addLine(to: CGPoint(x: 0.39127*width, y: 0.43877*height))
                    path.addCurve(to: CGPoint(x: 0.39764*width, y: 0.41049*height), control1: CGPoint(x: 0.38706*width, y: 0.42167*height), control2: CGPoint(x: 0.39366*width, y: 0.41466*height))
                    path.addCurve(to: CGPoint(x: 0.39937*width, y: 0.4086*height), control1: CGPoint(x: 0.39836*width, y: 0.40974*height), control2: CGPoint(x: 0.39894*width, y: 0.40912*height))
                    path.addCurve(to: CGPoint(x: 0.42975*width, y: 0.43568*height), control1: CGPoint(x: 0.41516*width, y: 0.41333*height), control2: CGPoint(x: 0.4341*width, y: 0.42164*height))
                    path.move(to: CGPoint(x: 0.53324*width, y: 0.4358*height))
                    path.addCurve(to: CGPoint(x: 0.54313*width, y: 0.44685*height), control1: CGPoint(x: 0.5344*width, y: 0.43972*height), control2: CGPoint(x: 0.53951*width, y: 0.4439*height))
                    path.addCurve(to: CGPoint(x: 0.55815*width, y: 0.44627*height), control1: CGPoint(x: 0.54817*width, y: 0.45096*height), control2: CGPoint(x: 0.55287*width, y: 0.44907*height))
                    path.addCurve(to: CGPoint(x: 0.57171*width, y: 0.4389*height), control1: CGPoint(x: 0.56278*width, y: 0.44386*height), control2: CGPoint(x: 0.5672*width, y: 0.44137*height))
                    path.addLine(to: CGPoint(x: 0.57227*width, y: 0.4387*height))
                    path.addCurve(to: CGPoint(x: 0.56567*width, y: 0.41052*height), control1: CGPoint(x: 0.57648*width, y: 0.42173*height), control2: CGPoint(x: 0.56965*width, y: 0.41469*height))
                    path.addCurve(to: CGPoint(x: 0.56396*width, y: 0.4086*height), control1: CGPoint(x: 0.56495*width, y: 0.40977*height), control2: CGPoint(x: 0.56442*width, y: 0.40912*height))
                    path.addCurve(to: CGPoint(x: 0.53324*width, y: 0.4358*height), control1: CGPoint(x: 0.54819*width, y: 0.41333*height), control2: CGPoint(x: 0.52891*width, y: 0.42176*height))
                    return path
                }
            }

            struct SerratusAnterior: Shape {
                func path(in rect: CGRect) -> Path {
                    var path = Path()
                    let width = rect.size.width
                    let height = rect.size.height
                    path.move(to: CGPoint(x: 0.426*width, y: 0.33877*height))
                    path.addCurve(to: CGPoint(x: 0.42366*width, y: 0.34472*height), control1: CGPoint(x: 0.42602*width, y: 0.34088*height), control2: CGPoint(x: 0.42475*width, y: 0.34281*height))
                    path.addCurve(to: CGPoint(x: 0.42194*width, y: 0.34616*height), control1: CGPoint(x: 0.42324*width, y: 0.34543*height), control2: CGPoint(x: 0.42326*width, y: 0.34628*height))
                    path.addCurve(to: CGPoint(x: 0.41894*width, y: 0.34477*height), control1: CGPoint(x: 0.42083*width, y: 0.34605*height), control2: CGPoint(x: 0.4197*width, y: 0.34526*height))
                    path.addCurve(to: CGPoint(x: 0.41549*width, y: 0.34261*height), control1: CGPoint(x: 0.41782*width, y: 0.34403*height), control2: CGPoint(x: 0.41667*width, y: 0.34332*height))
                    path.addCurve(to: CGPoint(x: 0.41002*width, y: 0.33926*height), control1: CGPoint(x: 0.41368*width, y: 0.3415*height), control2: CGPoint(x: 0.41164*width, y: 0.34048*height))
                    path.addCurve(to: CGPoint(x: 0.39831*width, y: 0.32835*height), control1: CGPoint(x: 0.40558*width, y: 0.33596*height), control2: CGPoint(x: 0.40157*width, y: 0.33218*height))
                    path.addCurve(to: CGPoint(x: 0.41187*width, y: 0.32622*height), control1: CGPoint(x: 0.40294*width, y: 0.32799*height), control2: CGPoint(x: 0.40752*width, y: 0.32725*height))
                    path.addLine(to: CGPoint(x: 0.41206*width, y: 0.32637*height))
                    path.addCurve(to: CGPoint(x: 0.426*width, y: 0.33877*height), control1: CGPoint(x: 0.4194*width, y: 0.3289*height), control2: CGPoint(x: 0.42588*width, y: 0.33324*height))
                    path.addLine(to: CGPoint(x: 0.426*width, y: 0.33877*height))
                    path.closeSubpath()
                    path.move(to: CGPoint(x: 0.41*width, y: 0.34066*height))
                    path.addCurve(to: CGPoint(x: 0.38956*width, y: 0.33432*height), control1: CGPoint(x: 0.40236*width, y: 0.33994*height), control2: CGPoint(x: 0.39542*width, y: 0.33778*height))
                    path.addLine(to: CGPoint(x: 0.38951*width, y: 0.33431*height))
                    path.addCurve(to: CGPoint(x: 0.39049*width, y: 0.32863*height), control1: CGPoint(x: 0.38965*width, y: 0.33245*height), control2: CGPoint(x: 0.38993*width, y: 0.33045*height))
                    path.addCurve(to: CGPoint(x: 0.39685*width, y: 0.32844*height), control1: CGPoint(x: 0.39264*width, y: 0.32863*height), control2: CGPoint(x: 0.39477*width, y: 0.32858*height))
                    path.addCurve(to: CGPoint(x: 0.40641*width, y: 0.33787*height), control1: CGPoint(x: 0.39963*width, y: 0.33168*height), control2: CGPoint(x: 0.40285*width, y: 0.33495*height))
                    path.addCurve(to: CGPoint(x: 0.41*width, y: 0.34066*height), control1: CGPoint(x: 0.40757*width, y: 0.33881*height), control2: CGPoint(x: 0.40875*width, y: 0.33975*height))
                    path.addLine(to: CGPoint(x: 0.41*width, y: 0.34066*height))
                    path.closeSubpath()
                    path.move(to: CGPoint(x: 0.42296*width, y: 0.36228*height))
                    path.addCurve(to: CGPoint(x: 0.41206*width, y: 0.35802*height), control1: CGPoint(x: 0.42144*width, y: 0.3689*height), control2: CGPoint(x: 0.41468*width, y: 0.36063*height))
                    path.addCurve(to: CGPoint(x: 0.40266*width, y: 0.34051*height), control1: CGPoint(x: 0.40701*width, y: 0.35298*height), control2: CGPoint(x: 0.40375*width, y: 0.34673*height))
                    path.addCurve(to: CGPoint(x: 0.4116*width, y: 0.34182*height), control1: CGPoint(x: 0.40551*width, y: 0.34117*height), control2: CGPoint(x: 0.40852*width, y: 0.3416*height))
                    path.addCurve(to: CGPoint(x: 0.41363*width, y: 0.34321*height), control1: CGPoint(x: 0.41227*width, y: 0.34228*height), control2: CGPoint(x: 0.41296*width, y: 0.34275*height))
                    path.addCurve(to: CGPoint(x: 0.41759*width, y: 0.34569*height), control1: CGPoint(x: 0.41493*width, y: 0.34406*height), control2: CGPoint(x: 0.41625*width, y: 0.34491*height))
                    path.addCurve(to: CGPoint(x: 0.42164*width, y: 0.34798*height), control1: CGPoint(x: 0.41875*width, y: 0.3464*height), control2: CGPoint(x: 0.41995*width, y: 0.34776*height))
                    path.addLine(to: CGPoint(x: 0.42167*width, y: 0.34799*height))
                    path.addCurve(to: CGPoint(x: 0.42296*width, y: 0.36228*height), control1: CGPoint(x: 0.42664*width, y: 0.3517*height), control2: CGPoint(x: 0.42391*width, y: 0.35804*height))
                    path.addLine(to: CGPoint(x: 0.42296*width, y: 0.36228*height))
                    path.closeSubpath()
                    path.move(to: CGPoint(x: 0.40562*width, y: 0.35171*height))
                    path.addCurve(to: CGPoint(x: 0.39111*width, y: 0.34551*height), control1: CGPoint(x: 0.40002*width, y: 0.35056*height), control2: CGPoint(x: 0.39505*width, y: 0.34843*height))
                    path.addCurve(to: CGPoint(x: 0.38944*width, y: 0.33552*height), control1: CGPoint(x: 0.38988*width, y: 0.34221*height), control2: CGPoint(x: 0.38935*width, y: 0.33886*height))
                    path.addCurve(to: CGPoint(x: 0.40106*width, y: 0.34014*height), control1: CGPoint(x: 0.39299*width, y: 0.33753*height), control2: CGPoint(x: 0.39687*width, y: 0.33906*height))
                    path.addCurve(to: CGPoint(x: 0.40562*width, y: 0.35171*height), control1: CGPoint(x: 0.40174*width, y: 0.34409*height), control2: CGPoint(x: 0.40329*width, y: 0.34801*height))
                    path.addLine(to: CGPoint(x: 0.40562*width, y: 0.35171*height))
                    path.closeSubpath()
                    path.move(to: CGPoint(x: 0.42144*width, y: 0.37961*height))
                    path.addCurve(to: CGPoint(x: 0.41477*width, y: 0.37773*height), control1: CGPoint(x: 0.4188*width, y: 0.38057*height), control2: CGPoint(x: 0.41657*width, y: 0.37878*height))
                    path.addCurve(to: CGPoint(x: 0.41088*width, y: 0.37471*height), control1: CGPoint(x: 0.41326*width, y: 0.37684*height), control2: CGPoint(x: 0.41208*width, y: 0.3758*height))
                    path.addCurve(to: CGPoint(x: 0.40361*width, y: 0.35227*height), control1: CGPoint(x: 0.40449*width, y: 0.3688*height), control2: CGPoint(x: 0.40331*width, y: 0.35932*height))
                    path.addCurve(to: CGPoint(x: 0.40634*width, y: 0.35284*height), control1: CGPoint(x: 0.40449*width, y: 0.3525*height), control2: CGPoint(x: 0.40539*width, y: 0.35269*height))
                    path.addCurve(to: CGPoint(x: 0.42157*width, y: 0.36693*height), control1: CGPoint(x: 0.40998*width, y: 0.35824*height), control2: CGPoint(x: 0.41519*width, y: 0.36315*height))
                    path.addCurve(to: CGPoint(x: 0.42287*width, y: 0.37455*height), control1: CGPoint(x: 0.42199*width, y: 0.36948*height), control2: CGPoint(x: 0.42248*width, y: 0.37199*height))
                    path.addCurve(to: CGPoint(x: 0.42144*width, y: 0.37961*height), control1: CGPoint(x: 0.42306*width, y: 0.37599*height), control2: CGPoint(x: 0.42384*width, y: 0.37875*height))
                    path.addLine(to: CGPoint(x: 0.42144*width, y: 0.37961*height))
                    path.closeSubpath()
                    path.move(to: CGPoint(x: 0.39972*width, y: 0.36142*height))
                    path.addLine(to: CGPoint(x: 0.39972*width, y: 0.3614*height))
                    path.addCurve(to: CGPoint(x: 0.3959*width, y: 0.35435*height), control1: CGPoint(x: 0.39877*width, y: 0.3594*height), control2: CGPoint(x: 0.39741*width, y: 0.35696*height))
                    path.addCurve(to: CGPoint(x: 0.39444*width, y: 0.35179*height), control1: CGPoint(x: 0.3959*width, y: 0.35435*height), control2: CGPoint(x: 0.39481*width, y: 0.35245*height))
                    path.addCurve(to: CGPoint(x: 0.39204*width, y: 0.34755*height), control1: CGPoint(x: 0.39363*width, y: 0.35037*height), control2: CGPoint(x: 0.3928*width, y: 0.34895*height))
                    path.addCurve(to: CGPoint(x: 0.40213*width, y: 0.3519*height), control1: CGPoint(x: 0.39502*width, y: 0.3494*height), control2: CGPoint(x: 0.3984*width, y: 0.35086*height))
                    path.addLine(to: CGPoint(x: 0.40211*width, y: 0.35201*height))
                    path.addCurve(to: CGPoint(x: 0.40329*width, y: 0.36392*height), control1: CGPoint(x: 0.40194*width, y: 0.35577*height), control2: CGPoint(x: 0.4022*width, y: 0.35992*height))
                    path.addCurve(to: CGPoint(x: 0.39972*width, y: 0.36142*height), control1: CGPoint(x: 0.40206*width, y: 0.36313*height), control2: CGPoint(x: 0.40086*width, y: 0.3623*height))
                    path.addLine(to: CGPoint(x: 0.39972*width, y: 0.36142*height))
                    path.closeSubpath()
                    path.move(to: CGPoint(x: 0.42343*width, y: 0.39523*height))
                    path.addCurve(to: CGPoint(x: 0.41475*width, y: 0.39227*height), control1: CGPoint(x: 0.41935*width, y: 0.39645*height), control2: CGPoint(x: 0.41687*width, y: 0.39414*height))
                    path.addCurve(to: CGPoint(x: 0.40153*width, y: 0.37216*height), control1: CGPoint(x: 0.40799*width, y: 0.38634*height), control2: CGPoint(x: 0.40343*width, y: 0.37944*height))
                    path.addLine(to: CGPoint(x: 0.40153*width, y: 0.37213*height))
                    path.addCurve(to: CGPoint(x: 0.40104*width, y: 0.36463*height), control1: CGPoint(x: 0.40148*width, y: 0.36841*height), control2: CGPoint(x: 0.40132*width, y: 0.36569*height))
                    path.addCurve(to: CGPoint(x: 0.40067*width, y: 0.36361*height), control1: CGPoint(x: 0.40097*width, y: 0.36432*height), control2: CGPoint(x: 0.40083*width, y: 0.36397*height))
                    path.addCurve(to: CGPoint(x: 0.40387*width, y: 0.3656*height), control1: CGPoint(x: 0.40169*width, y: 0.36431*height), control2: CGPoint(x: 0.40275*width, y: 0.36497*height))
                    path.addCurve(to: CGPoint(x: 0.41664*width, y: 0.37991*height), control1: CGPoint(x: 0.40581*width, y: 0.37128*height), control2: CGPoint(x: 0.40965*width, y: 0.37657*height))
                    path.addCurve(to: CGPoint(x: 0.42192*width, y: 0.38113*height), control1: CGPoint(x: 0.419*width, y: 0.38103*height), control2: CGPoint(x: 0.42072*width, y: 0.38136*height))
                    path.addCurve(to: CGPoint(x: 0.42266*width, y: 0.38262*height), control1: CGPoint(x: 0.42227*width, y: 0.38176*height), control2: CGPoint(x: 0.42259*width, y: 0.38248*height))
                    path.addCurve(to: CGPoint(x: 0.4238*width, y: 0.38559*height), control1: CGPoint(x: 0.42312*width, y: 0.3836*height), control2: CGPoint(x: 0.42352*width, y: 0.3846*height))
                    path.addCurve(to: CGPoint(x: 0.42509*width, y: 0.39164*height), control1: CGPoint(x: 0.42437*width, y: 0.38759*height), control2: CGPoint(x: 0.42465*width, y: 0.38961*height))
                    path.addCurve(to: CGPoint(x: 0.42343*width, y: 0.39523*height), control1: CGPoint(x: 0.42542*width, y: 0.39296*height), control2: CGPoint(x: 0.42558*width, y: 0.39458*height))
                    path.addLine(to: CGPoint(x: 0.42343*width, y: 0.39523*height))
                    path.closeSubpath()
                    path.move(to: CGPoint(x: 0.42419*width, y: 0.40778*height))
                    path.addCurve(to: CGPoint(x: 0.42074*width, y: 0.411*height), control1: CGPoint(x: 0.42444*width, y: 0.40912*height), control2: CGPoint(x: 0.42319*width, y: 0.41123*height))
                    path.addCurve(to: CGPoint(x: 0.41701*width, y: 0.41002*height), control1: CGPoint(x: 0.41951*width, y: 0.4109*height), control2: CGPoint(x: 0.41808*width, y: 0.41046*height))
                    path.addCurve(to: CGPoint(x: 0.40125*width, y: 0.39929*height), control1: CGPoint(x: 0.41056*width, y: 0.40738*height), control2: CGPoint(x: 0.40528*width, y: 0.40356*height))
                    path.addLine(to: CGPoint(x: 0.40125*width, y: 0.39927*height))
                    path.addCurve(to: CGPoint(x: 0.4016*width, y: 0.37679*height), control1: CGPoint(x: 0.40144*width, y: 0.3917*height), control2: CGPoint(x: 0.40162*width, y: 0.38341*height))
                    path.addCurve(to: CGPoint(x: 0.40741*width, y: 0.38647*height), control1: CGPoint(x: 0.40303*width, y: 0.38011*height), control2: CGPoint(x: 0.40498*width, y: 0.38332*height))
                    path.addCurve(to: CGPoint(x: 0.42162*width, y: 0.39787*height), control1: CGPoint(x: 0.41*width, y: 0.3898*height), control2: CGPoint(x: 0.41544*width, y: 0.39673*height))
                    path.addCurve(to: CGPoint(x: 0.42398*width, y: 0.3979*height), control1: CGPoint(x: 0.42255*width, y: 0.39804*height), control2: CGPoint(x: 0.42336*width, y: 0.39804*height))
                    path.addCurve(to: CGPoint(x: 0.4244*width, y: 0.40358*height), control1: CGPoint(x: 0.42421*width, y: 0.39978*height), control2: CGPoint(x: 0.42437*width, y: 0.40168*height))
                    path.addCurve(to: CGPoint(x: 0.42419*width, y: 0.40778*height), control1: CGPoint(x: 0.4244*width, y: 0.40497*height), control2: CGPoint(x: 0.42428*width, y: 0.40637*height))
                    path.addLine(to: CGPoint(x: 0.42419*width, y: 0.40778*height))
                    path.closeSubpath()
                    path.move(to: CGPoint(x: 0.5365*width, y: 0.3388*height))
                    path.addCurve(to: CGPoint(x: 0.53884*width, y: 0.34475*height), control1: CGPoint(x: 0.53639*width, y: 0.34091*height), control2: CGPoint(x: 0.53775*width, y: 0.34284*height))
                    path.addCurve(to: CGPoint(x: 0.54086*width, y: 0.3463*height), control1: CGPoint(x: 0.53926*width, y: 0.34546*height), control2: CGPoint(x: 0.53954*width, y: 0.3464*height))
                    path.addCurve(to: CGPoint(x: 0.54398*width, y: 0.34478*height), control1: CGPoint(x: 0.54197*width, y: 0.34619*height), control2: CGPoint(x: 0.54324*width, y: 0.34528*height))
                    path.addCurve(to: CGPoint(x: 0.54743*width, y: 0.34262*height), control1: CGPoint(x: 0.54509*width, y: 0.34404*height), control2: CGPoint(x: 0.54627*width, y: 0.34333*height))
                    path.addCurve(to: CGPoint(x: 0.55289*width, y: 0.33927*height), control1: CGPoint(x: 0.54924*width, y: 0.34151*height), control2: CGPoint(x: 0.55127*width, y: 0.34049*height))
                    path.addCurve(to: CGPoint(x: 0.56505*width, y: 0.32772*height), control1: CGPoint(x: 0.55736*width, y: 0.33597*height), control2: CGPoint(x: 0.56178*width, y: 0.33156*height))
                    path.addCurve(to: CGPoint(x: 0.55109*width, y: 0.32588*height), control1: CGPoint(x: 0.56042*width, y: 0.32735*height), control2: CGPoint(x: 0.55544*width, y: 0.32691*height))
                    path.addLine(to: CGPoint(x: 0.55067*width, y: 0.32596*height))
                    path.addCurve(to: CGPoint(x: 0.5365*width, y: 0.3388*height), control1: CGPoint(x: 0.54336*width, y: 0.32849*height), control2: CGPoint(x: 0.53685*width, y: 0.33269*height))
                    path.closeSubpath()
                    path.move(to: CGPoint(x: 0.55164*width, y: 0.341*height))
                    path.addCurve(to: CGPoint(x: 0.5734*width, y: 0.33434*height), control1: CGPoint(x: 0.55928*width, y: 0.34028*height), control2: CGPoint(x: 0.56755*width, y: 0.33779*height))
                    path.addLine(to: CGPoint(x: 0.57345*width, y: 0.33432*height))
                    path.addCurve(to: CGPoint(x: 0.57285*width, y: 0.3281*height), control1: CGPoint(x: 0.57331*width, y: 0.33247*height), control2: CGPoint(x: 0.57338*width, y: 0.32994*height))
                    path.addCurve(to: CGPoint(x: 0.56602*width, y: 0.32773*height), control1: CGPoint(x: 0.57069*width, y: 0.3281*height), control2: CGPoint(x: 0.56813*width, y: 0.32787*height))
                    path.addCurve(to: CGPoint(x: 0.55164*width, y: 0.341*height), control1: CGPoint(x: 0.56324*width, y: 0.33097*height), control2: CGPoint(x: 0.55164*width, y: 0.341*height))
                    path.closeSubpath()
                    path.move(to: CGPoint(x: 0.53979*width, y: 0.36272*height))
                    path.addCurve(to: CGPoint(x: 0.55088*width, y: 0.35804*height), control1: CGPoint(x: 0.54132*width, y: 0.36934*height), control2: CGPoint(x: 0.54826*width, y: 0.36066*height))
                    path.addCurve(to: CGPoint(x: 0.5603*width, y: 0.34051*height), control1: CGPoint(x: 0.55593*width, y: 0.35299*height), control2: CGPoint(x: 0.55921*width, y: 0.34674*height))
                    path.addCurve(to: CGPoint(x: 0.55088*width, y: 0.34151*height), control1: CGPoint(x: 0.55745*width, y: 0.34117*height), control2: CGPoint(x: 0.55398*width, y: 0.34128*height))
                    path.addCurve(to: CGPoint(x: 0.54884*width, y: 0.3429*height), control1: CGPoint(x: 0.55021*width, y: 0.34198*height), control2: CGPoint(x: 0.54951*width, y: 0.34244*height))
                    path.addCurve(to: CGPoint(x: 0.54488*width, y: 0.34539*height), control1: CGPoint(x: 0.54755*width, y: 0.34375*height), control2: CGPoint(x: 0.54623*width, y: 0.3446*height))
                    path.addCurve(to: CGPoint(x: 0.54132*width, y: 0.34733*height), control1: CGPoint(x: 0.54373*width, y: 0.3461*height), control2: CGPoint(x: 0.54299*width, y: 0.34713*height))
                    path.addLine(to: CGPoint(x: 0.54074*width, y: 0.34775*height))
                    path.addCurve(to: CGPoint(x: 0.53968*width, y: 0.36231*height), control1: CGPoint(x: 0.53576*width, y: 0.35147*height), control2: CGPoint(x: 0.53873*width, y: 0.35807*height))
                    path.addLine(to: CGPoint(x: 0.53979*width, y: 0.36272*height))
                    path.closeSubpath()
                    path.move(to: CGPoint(x: 0.55759*width, y: 0.35174*height))
                    path.addCurve(to: CGPoint(x: 0.57269*width, y: 0.34528*height), control1: CGPoint(x: 0.56319*width, y: 0.35059*height), control2: CGPoint(x: 0.56875*width, y: 0.34819*height))
                    path.addCurve(to: CGPoint(x: 0.57375*width, y: 0.3352*height), control1: CGPoint(x: 0.57391*width, y: 0.34198*height), control2: CGPoint(x: 0.57384*width, y: 0.33853*height))
                    path.addCurve(to: CGPoint(x: 0.56157*width, y: 0.33995*height), control1: CGPoint(x: 0.57021*width, y: 0.33721*height), control2: CGPoint(x: 0.56576*width, y: 0.33889*height))
                    path.addCurve(to: CGPoint(x: 0.55667*width, y: 0.35174*height), control1: CGPoint(x: 0.56093*width, y: 0.34389*height), control2: CGPoint(x: 0.559*width, y: 0.34802*height))
                    path.addLine(to: CGPoint(x: 0.55759*width, y: 0.35174*height))
                    path.closeSubpath()
                    path.move(to: CGPoint(x: 0.54139*width, y: 0.37985*height))
                    path.addCurve(to: CGPoint(x: 0.54817*width, y: 0.37778*height), control1: CGPoint(x: 0.54403*width, y: 0.3808*height), control2: CGPoint(x: 0.54637*width, y: 0.37883*height))
                    path.addCurve(to: CGPoint(x: 0.55206*width, y: 0.37475*height), control1: CGPoint(x: 0.54968*width, y: 0.37688*height), control2: CGPoint(x: 0.55086*width, y: 0.37585*height))
                    path.addCurve(to: CGPoint(x: 0.55935*width, y: 0.35168*height), control1: CGPoint(x: 0.55847*width, y: 0.36884*height), control2: CGPoint(x: 0.55963*width, y: 0.35873*height))
                    path.addCurve(to: CGPoint(x: 0.55662*width, y: 0.35225*height), control1: CGPoint(x: 0.55847*width, y: 0.35191*height), control2: CGPoint(x: 0.55757*width, y: 0.3521*height))
                    path.addCurve(to: CGPoint(x: 0.5409*width, y: 0.36636*height), control1: CGPoint(x: 0.55299*width, y: 0.35767*height), control2: CGPoint(x: 0.54731*width, y: 0.36258*height))
                    path.addCurve(to: CGPoint(x: 0.53961*width, y: 0.3746*height), control1: CGPoint(x: 0.54049*width, y: 0.3689*height), control2: CGPoint(x: 0.54*width, y: 0.37205*height))
                    path.addCurve(to: CGPoint(x: 0.54111*width, y: 0.37966*height), control1: CGPoint(x: 0.5394*width, y: 0.37603*height), control2: CGPoint(x: 0.53868*width, y: 0.3788*height))
                    path.addLine(to: CGPoint(x: 0.54139*width, y: 0.37985*height))
                    path.closeSubpath()
                    path.move(to: CGPoint(x: 0.56312*width, y: 0.36145*height))
                    path.addLine(to: CGPoint(x: 0.56447*width, y: 0.36035*height))
                    path.addCurve(to: CGPoint(x: 0.56819*width, y: 0.35344*height), control1: CGPoint(x: 0.56542*width, y: 0.35835*height), control2: CGPoint(x: 0.56819*width, y: 0.35344*height))
                    path.addCurve(to: CGPoint(x: 0.57234*width, y: 0.34603*height), control1: CGPoint(x: 0.56819*width, y: 0.35344*height), control2: CGPoint(x: 0.57155*width, y: 0.34744*height))
                    path.addCurve(to: CGPoint(x: 0.56197*width, y: 0.35074*height), control1: CGPoint(x: 0.56935*width, y: 0.34789*height), control2: CGPoint(x: 0.56569*width, y: 0.34971*height))
                    path.addLine(to: CGPoint(x: 0.56035*width, y: 0.35142*height))
                    path.addCurve(to: CGPoint(x: 0.55926*width, y: 0.36395*height), control1: CGPoint(x: 0.56051*width, y: 0.35519*height), control2: CGPoint(x: 0.56035*width, y: 0.35994*height))
                    path.addCurve(to: CGPoint(x: 0.56255*width, y: 0.36181*height), control1: CGPoint(x: 0.56053*width, y: 0.36315*height), control2: CGPoint(x: 0.56141*width, y: 0.36269*height))
                    path.addLine(to: CGPoint(x: 0.56312*width, y: 0.36145*height))
                    path.closeSubpath()
                    path.move(to: CGPoint(x: 0.53903*width, y: 0.3956*height))
                    path.addCurve(to: CGPoint(x: 0.54817*width, y: 0.39231*height), control1: CGPoint(x: 0.5431*width, y: 0.39684*height), control2: CGPoint(x: 0.54606*width, y: 0.3942*height))
                    path.addCurve(to: CGPoint(x: 0.56137*width, y: 0.37289*height), control1: CGPoint(x: 0.55493*width, y: 0.38639*height), control2: CGPoint(x: 0.55947*width, y: 0.38015*height))
                    path.addLine(to: CGPoint(x: 0.56252*width, y: 0.36951*height))
                    path.addCurve(to: CGPoint(x: 0.56273*width, y: 0.36397*height), control1: CGPoint(x: 0.56257*width, y: 0.36579*height), control2: CGPoint(x: 0.56245*width, y: 0.36502*height))
                    path.addCurve(to: CGPoint(x: 0.5634*width, y: 0.36225*height), control1: CGPoint(x: 0.5628*width, y: 0.36366*height), control2: CGPoint(x: 0.56324*width, y: 0.36262*height))
                    path.addCurve(to: CGPoint(x: 0.55859*width, y: 0.36502*height), control1: CGPoint(x: 0.56238*width, y: 0.36295*height), control2: CGPoint(x: 0.5597*width, y: 0.36438*height))
                    path.addCurve(to: CGPoint(x: 0.54616*width, y: 0.37915*height), control1: CGPoint(x: 0.55664*width, y: 0.37069*height), control2: CGPoint(x: 0.55315*width, y: 0.37582*height))
                    path.addCurve(to: CGPoint(x: 0.54069*width, y: 0.38043*height), control1: CGPoint(x: 0.5438*width, y: 0.38028*height), control2: CGPoint(x: 0.54192*width, y: 0.38066*height))
                    path.addCurve(to: CGPoint(x: 0.53977*width, y: 0.38267*height), control1: CGPoint(x: 0.54035*width, y: 0.38106*height), control2: CGPoint(x: 0.53984*width, y: 0.38253*height))
                    path.addCurve(to: CGPoint(x: 0.53863*width, y: 0.38565*height), control1: CGPoint(x: 0.53931*width, y: 0.38364*height), control2: CGPoint(x: 0.53891*width, y: 0.38465*height))
                    path.addCurve(to: CGPoint(x: 0.53734*width, y: 0.3917*height), control1: CGPoint(x: 0.53806*width, y: 0.38765*height), control2: CGPoint(x: 0.53778*width, y: 0.38968*height))
                    path.addCurve(to: CGPoint(x: 0.53949*width, y: 0.3956*height), control1: CGPoint(x: 0.53704*width, y: 0.39301*height), control2: CGPoint(x: 0.53734*width, y: 0.39495*height))
                    path.addLine(to: CGPoint(x: 0.53903*width, y: 0.3956*height))
                    path.closeSubpath()
                    path.move(to: CGPoint(x: 0.53875*width, y: 0.40778*height))
                    path.addCurve(to: CGPoint(x: 0.5422*width, y: 0.411*height), control1: CGPoint(x: 0.5385*width, y: 0.40912*height), control2: CGPoint(x: 0.53975*width, y: 0.41123*height))
                    path.addCurve(to: CGPoint(x: 0.54593*width, y: 0.41002*height), control1: CGPoint(x: 0.54343*width, y: 0.4109*height), control2: CGPoint(x: 0.54486*width, y: 0.41046*height))
                    path.addCurve(to: CGPoint(x: 0.5625*width, y: 0.39861*height), control1: CGPoint(x: 0.55238*width, y: 0.40738*height), control2: CGPoint(x: 0.55752*width, y: 0.40401*height))
                    path.addCurve(to: CGPoint(x: 0.56201*width, y: 0.37394*height), control1: CGPoint(x: 0.5625*width, y: 0.39861*height), control2: CGPoint(x: 0.56199*width, y: 0.38056*height))
                    path.addCurve(to: CGPoint(x: 0.55556*width, y: 0.38583*height), control1: CGPoint(x: 0.56058*width, y: 0.37725*height), control2: CGPoint(x: 0.55799*width, y: 0.38269*height))
                    path.addCurve(to: CGPoint(x: 0.54134*width, y: 0.39724*height), control1: CGPoint(x: 0.55296*width, y: 0.38917*height), control2: CGPoint(x: 0.54752*width, y: 0.3961*height))
                    path.addCurve(to: CGPoint(x: 0.53898*width, y: 0.39727*height), control1: CGPoint(x: 0.54042*width, y: 0.39741*height), control2: CGPoint(x: 0.53961*width, y: 0.39741*height))
                    path.addCurve(to: CGPoint(x: 0.53856*width, y: 0.40358*height), control1: CGPoint(x: 0.53875*width, y: 0.39915*height), control2: CGPoint(x: 0.53859*width, y: 0.40168*height))
                    path.addCurve(to: CGPoint(x: 0.53875*width, y: 0.40778*height), control1: CGPoint(x: 0.53854*width, y: 0.40497*height), control2: CGPoint(x: 0.53866*width, y: 0.40637*height))
                    path.addLine(to: CGPoint(x: 0.53875*width, y: 0.40778*height))
                    path.closeSubpath()
                    return path
                }
            }
        }

        struct Pectorals: Shape {
            func path(in rect: CGRect) -> Path {
                var path = Path()
                path.addPath(PectoralisMajor().path(in: rect))
                return path.offsetBy(dx: 0.04675 * rect.size.width, dy: 0)
            }

            struct PectoralisMajor: Shape {
                func path(in rect: CGRect) -> Path {
                    var path = Path()
                    let width = rect.size.width
                    let height = rect.size.height
                    path.move(to: CGPoint(x: 0.4572*width, y: 0.28687*height))
                    path.addCurve(to: CGPoint(x: 0.46988*width, y: 0.31236*height), control1: CGPoint(x: 0.45852*width, y: 0.29559*height), control2: CGPoint(x: 0.46021*width, y: 0.3059*height))
                    path.addCurve(to: CGPoint(x: 0.52648*width, y: 0.32102*height), control1: CGPoint(x: 0.48238*width, y: 0.32069*height), control2: CGPoint(x: 0.51005*width, y: 0.32573*height))
                    path.addCurve(to: CGPoint(x: 0.56896*width, y: 0.29066*height), control1: CGPoint(x: 0.54442*width, y: 0.31588*height), control2: CGPoint(x: 0.55907*width, y: 0.30145*height))
                    path.addCurve(to: CGPoint(x: 0.55926*width, y: 0.27383*height), control1: CGPoint(x: 0.5675*width, y: 0.28398*height), control2: CGPoint(x: 0.565*width, y: 0.27853*height))
                    path.addCurve(to: CGPoint(x: 0.54972*width, y: 0.26593*height), control1: CGPoint(x: 0.55748*width, y: 0.27267*height), control2: CGPoint(x: 0.54972*width, y: 0.26593*height))
                    path.addCurve(to: CGPoint(x: 0.5072*width, y: 0.25108*height), control1: CGPoint(x: 0.53644*width, y: 0.25785*height), control2: CGPoint(x: 0.53435*width, y: 0.25123*height))
                    path.addCurve(to: CGPoint(x: 0.45741*width, y: 0.26426*height), control1: CGPoint(x: 0.47792*width, y: 0.25093*height), control2: CGPoint(x: 0.46745*width, y: 0.2539*height))
                    path.addCurve(to: CGPoint(x: 0.4572*width, y: 0.28687*height), control1: CGPoint(x: 0.45231*width, y: 0.26954*height), control2: CGPoint(x: 0.45634*width, y: 0.2811*height))
                    path.move(to: CGPoint(x: 0.44836*width, y: 0.2861*height))
                    path.addCurve(to: CGPoint(x: 0.43567*width, y: 0.31159*height), control1: CGPoint(x: 0.44704*width, y: 0.29481*height), control2: CGPoint(x: 0.44535*width, y: 0.30512*height))
                    path.addCurve(to: CGPoint(x: 0.37907*width, y: 0.32025*height), control1: CGPoint(x: 0.42317*width, y: 0.31992*height), control2: CGPoint(x: 0.39551*width, y: 0.32495*height))
                    path.addCurve(to: CGPoint(x: 0.3366*width, y: 0.28989*height), control1: CGPoint(x: 0.36113*width, y: 0.31511*height), control2: CGPoint(x: 0.34648*width, y: 0.30068*height))
                    path.addCurve(to: CGPoint(x: 0.3463*width, y: 0.27306*height), control1: CGPoint(x: 0.33806*width, y: 0.28321*height), control2: CGPoint(x: 0.34056*width, y: 0.27776*height))
                    path.addCurve(to: CGPoint(x: 0.35583*width, y: 0.26515*height), control1: CGPoint(x: 0.34808*width, y: 0.2719*height), control2: CGPoint(x: 0.35583*width, y: 0.26515*height))
                    path.addCurve(to: CGPoint(x: 0.39836*width, y: 0.25031*height), control1: CGPoint(x: 0.36912*width, y: 0.25708*height), control2: CGPoint(x: 0.3712*width, y: 0.25046*height))
                    path.addCurve(to: CGPoint(x: 0.44815*width, y: 0.26349*height), control1: CGPoint(x: 0.42764*width, y: 0.25015*height), control2: CGPoint(x: 0.4381*width, y: 0.25313*height))
                    path.addCurve(to: CGPoint(x: 0.44836*width, y: 0.2861*height), control1: CGPoint(x: 0.45324*width, y: 0.26877*height), control2: CGPoint(x: 0.44921*width, y: 0.28034*height))
                    return path.offsetBy(dx: 0.00065 * rect.size.width, dy: 0)
                }
            }
        }

        struct Quadriceps: Shape {
            func path(in rect: CGRect) -> Path {
                var path = Path()
                path.addPath(RectusFemoris().path(in: rect))
                path.addPath(VastusLateralis().path(in: rect))
                path.addPath(VastusMedialis().path(in: rect))
                return path
                    .offsetBy(dx: 0.018 * rect.size.width, dy: 0)
            }

            struct RectusFemoris: Shape {
                func path(in rect: CGRect) -> Path {
                    var path = Path()
                    let width = rect.size.width
                    let height = rect.size.height
                    path.move(to: CGPoint(x: 0.59144*width, y: 0.51455*height))
                    path.addCurve(to: CGPoint(x: 0.59012*width, y: 0.50943*height), control1: CGPoint(x: 0.59063*width, y: 0.51227*height), control2: CGPoint(x: 0.59093*width, y: 0.51156*height))
                    path.addLine(to: CGPoint(x: 0.58933*width, y: 0.50779*height))
                    path.addCurve(to: CGPoint(x: 0.56613*width, y: 0.47451*height), control1: CGPoint(x: 0.57109*width, y: 0.50216*height), control2: CGPoint(x: 0.56912*width, y: 0.48639*height))
                    path.addCurve(to: CGPoint(x: 0.57398*width, y: 0.44574*height), control1: CGPoint(x: 0.56368*width, y: 0.46472*height), control2: CGPoint(x: 0.56315*width, y: 0.45301*height))
                    path.addCurve(to: CGPoint(x: 0.57104*width, y: 0.43986*height), control1: CGPoint(x: 0.57269*width, y: 0.4427*height), control2: CGPoint(x: 0.57104*width, y: 0.43986*height))
                    path.addLine(to: CGPoint(x: 0.57044*width, y: 0.44012*height))
                    path.addCurve(to: CGPoint(x: 0.55002*width, y: 0.45054*height), control1: CGPoint(x: 0.56382*width, y: 0.44373*height), control2: CGPoint(x: 0.5572*width, y: 0.44744*height))
                    path.addCurve(to: CGPoint(x: 0.54905*width, y: 0.45083*height), control1: CGPoint(x: 0.5497*width, y: 0.45068*height), control2: CGPoint(x: 0.5494*width, y: 0.45079*height))
                    path.addCurve(to: CGPoint(x: 0.53766*width, y: 0.46389*height), control1: CGPoint(x: 0.54523*width, y: 0.45441*height), control2: CGPoint(x: 0.54164*width, y: 0.45877*height))
                    path.addLine(to: CGPoint(x: 0.53769*width, y: 0.4741*height))
                    path.addCurve(to: CGPoint(x: 0.5403*width, y: 0.46687*height), control1: CGPoint(x: 0.53801*width, y: 0.47304*height), control2: CGPoint(x: 0.53995*width, y: 0.46793*height))
                    path.addCurve(to: CGPoint(x: 0.55123*width, y: 0.45372*height), control1: CGPoint(x: 0.54183*width, y: 0.46235*height), control2: CGPoint(x: 0.54736*width, y: 0.45752*height))
                    path.addCurve(to: CGPoint(x: 0.55681*width, y: 0.4523*height), control1: CGPoint(x: 0.55236*width, y: 0.45259*height), control2: CGPoint(x: 0.55493*width, y: 0.45142*height))
                    path.addCurve(to: CGPoint(x: 0.5597*width, y: 0.47793*height), control1: CGPoint(x: 0.56641*width, y: 0.45677*height), control2: CGPoint(x: 0.56076*width, y: 0.47205*height))
                    path.addCurve(to: CGPoint(x: 0.53877*width, y: 0.52644*height), control1: CGPoint(x: 0.55671*width, y: 0.49466*height), control2: CGPoint(x: 0.54819*width, y: 0.51085*height))
                    path.addCurve(to: CGPoint(x: 0.52262*width, y: 0.55028*height), control1: CGPoint(x: 0.53387*width, y: 0.53458*height), control2: CGPoint(x: 0.52792*width, y: 0.54227*height))
                    path.addCurve(to: CGPoint(x: 0.55988*width, y: 0.61471*height), control1: CGPoint(x: 0.53148*width, y: 0.5714*height), control2: CGPoint(x: 0.55806*width, y: 0.59233*height))
                    path.addLine(to: CGPoint(x: 0.55988*width, y: 0.61472*height))
                    path.addCurve(to: CGPoint(x: 0.56748*width, y: 0.61497*height), control1: CGPoint(x: 0.5622*width, y: 0.61574*height), control2: CGPoint(x: 0.56514*width, y: 0.61577*height))
                    path.addCurve(to: CGPoint(x: 0.57021*width, y: 0.60454*height), control1: CGPoint(x: 0.56771*width, y: 0.61123*height), control2: CGPoint(x: 0.56921*width, y: 0.60778*height))
                    path.addCurve(to: CGPoint(x: 0.59081*width, y: 0.5567*height), control1: CGPoint(x: 0.57523*width, y: 0.58824*height), control2: CGPoint(x: 0.58664*width, y: 0.57329*height))
                    path.addCurve(to: CGPoint(x: 0.59144*width, y: 0.51455*height), control1: CGPoint(x: 0.59424*width, y: 0.54285*height), control2: CGPoint(x: 0.59447*width, y: 0.52846*height))
                    path.closeSubpath()
                    path.move(to: CGPoint(x: 0.37296*width, y: 0.51495*height))
                    path.addCurve(to: CGPoint(x: 0.37544*width, y: 0.50833*height), control1: CGPoint(x: 0.37377*width, y: 0.51267*height), control2: CGPoint(x: 0.37463*width, y: 0.51046*height))
                    path.addLine(to: CGPoint(x: 0.37558*width, y: 0.50779*height))
                    path.addCurve(to: CGPoint(x: 0.39773*width, y: 0.47469*height), control1: CGPoint(x: 0.39382*width, y: 0.50216*height), control2: CGPoint(x: 0.39475*width, y: 0.48657*height))
                    path.addCurve(to: CGPoint(x: 0.38988*width, y: 0.44593*height), control1: CGPoint(x: 0.40019*width, y: 0.46491*height), control2: CGPoint(x: 0.40072*width, y: 0.45319*height))
                    path.addCurve(to: CGPoint(x: 0.39315*width, y: 0.43969*height), control1: CGPoint(x: 0.39118*width, y: 0.44289*height), control2: CGPoint(x: 0.39315*width, y: 0.43969*height))
                    path.addLine(to: CGPoint(x: 0.39375*width, y: 0.43995*height))
                    path.addCurve(to: CGPoint(x: 0.41417*width, y: 0.45037*height), control1: CGPoint(x: 0.40037*width, y: 0.44356*height), control2: CGPoint(x: 0.40699*width, y: 0.44727*height))
                    path.addCurve(to: CGPoint(x: 0.41481*width, y: 0.45102*height), control1: CGPoint(x: 0.41449*width, y: 0.45051*height), control2: CGPoint(x: 0.41447*width, y: 0.45097*height))
                    path.addCurve(to: CGPoint(x: 0.4262*width, y: 0.46407*height), control1: CGPoint(x: 0.41863*width, y: 0.4546*height), control2: CGPoint(x: 0.42222*width, y: 0.45895*height))
                    path.addLine(to: CGPoint(x: 0.42627*width, y: 0.47471*height))
                    path.addCurve(to: CGPoint(x: 0.42356*width, y: 0.46705*height), control1: CGPoint(x: 0.42595*width, y: 0.47364*height), control2: CGPoint(x: 0.42391*width, y: 0.4681*height))
                    path.addCurve(to: CGPoint(x: 0.41264*width, y: 0.4539*height), control1: CGPoint(x: 0.42204*width, y: 0.46253*height), control2: CGPoint(x: 0.4165*width, y: 0.4577*height))
                    path.addCurve(to: CGPoint(x: 0.40706*width, y: 0.45248*height), control1: CGPoint(x: 0.4115*width, y: 0.45278*height), control2: CGPoint(x: 0.40894*width, y: 0.4516*height))
                    path.addCurve(to: CGPoint(x: 0.40417*width, y: 0.47812*height), control1: CGPoint(x: 0.39745*width, y: 0.45696*height), control2: CGPoint(x: 0.4031*width, y: 0.47224*height))
                    path.addCurve(to: CGPoint(x: 0.42509*width, y: 0.52662*height), control1: CGPoint(x: 0.40715*width, y: 0.49485*height), control2: CGPoint(x: 0.41567*width, y: 0.51103*height))
                    path.addCurve(to: CGPoint(x: 0.44125*width, y: 0.55046*height), control1: CGPoint(x: 0.43*width, y: 0.53477*height), control2: CGPoint(x: 0.43595*width, y: 0.54245*height))
                    path.addCurve(to: CGPoint(x: 0.40398*width, y: 0.61489*height), control1: CGPoint(x: 0.43238*width, y: 0.57159*height), control2: CGPoint(x: 0.40581*width, y: 0.59252*height))
                    path.addLine(to: CGPoint(x: 0.40398*width, y: 0.61491*height))
                    path.addCurve(to: CGPoint(x: 0.39639*width, y: 0.61515*height), control1: CGPoint(x: 0.40167*width, y: 0.61593*height), control2: CGPoint(x: 0.39873*width, y: 0.61596*height))
                    path.addCurve(to: CGPoint(x: 0.39433*width, y: 0.60451*height), control1: CGPoint(x: 0.39616*width, y: 0.61142*height), control2: CGPoint(x: 0.39532*width, y: 0.60776*height))
                    path.addCurve(to: CGPoint(x: 0.37303*width, y: 0.55687*height), control1: CGPoint(x: 0.38931*width, y: 0.58821*height), control2: CGPoint(x: 0.3772*width, y: 0.57346*height))
                    path.addCurve(to: CGPoint(x: 0.37296*width, y: 0.51495*height), control1: CGPoint(x: 0.36963*width, y: 0.54306*height), control2: CGPoint(x: 0.36993*width, y: 0.52887*height))
                    path.closeSubpath()
                    return path.offsetBy(dx: -0.0005 * rect.size.width, dy: 0)
                }
            }

            struct VastusLateralis: Shape {
                func path(in rect: CGRect) -> Path {
                    var path = Path()
                    let width = rect.size.width
                    let height = rect.size.height
                    path.move(to: CGPoint(x: 0.39468*width, y: 0.6108*height))
                    path.addCurve(to: CGPoint(x: 0.37498*width, y: 0.566*height), control1: CGPoint(x: 0.38984*width, y: 0.59535*height), control2: CGPoint(x: 0.37931*width, y: 0.57975*height))
                    path.addCurve(to: CGPoint(x: 0.37032*width, y: 0.5213*height), control1: CGPoint(x: 0.36995*width, y: 0.5502*height), control2: CGPoint(x: 0.36824*width, y: 0.53721*height))
                    path.addCurve(to: CGPoint(x: 0.35954*width, y: 0.56008*height), control1: CGPoint(x: 0.36655*width, y: 0.53265*height), control2: CGPoint(x: 0.36275*width, y: 0.54633*height))
                    path.addCurve(to: CGPoint(x: 0.36975*width, y: 0.65154*height), control1: CGPoint(x: 0.35505*width, y: 0.5792*height), control2: CGPoint(x: 0.35488*width, y: 0.59856*height))
                    path.addCurve(to: CGPoint(x: 0.39257*width, y: 0.6439*height), control1: CGPoint(x: 0.37141*width, y: 0.65748*height), control2: CGPoint(x: 0.38866*width, y: 0.65*height))
                    path.addCurve(to: CGPoint(x: 0.39741*width, y: 0.62897*height), control1: CGPoint(x: 0.39514*width, y: 0.63981*height), control2: CGPoint(x: 0.39711*width, y: 0.63344*height))
                    path.addCurve(to: CGPoint(x: 0.39468*width, y: 0.6108*height), control1: CGPoint(x: 0.39738*width, y: 0.62897*height), control2: CGPoint(x: 0.39687*width, y: 0.61778*height))
                    path.closeSubpath()
                    path.move(to: CGPoint(x: 0.56836*width, y: 0.61106*height))
                    path.addCurve(to: CGPoint(x: 0.58806*width, y: 0.56627*height), control1: CGPoint(x: 0.57319*width, y: 0.59562*height), control2: CGPoint(x: 0.58373*width, y: 0.58002*height))
                    path.addCurve(to: CGPoint(x: 0.59326*width, y: 0.52171*height), control1: CGPoint(x: 0.59308*width, y: 0.55046*height), control2: CGPoint(x: 0.59537*width, y: 0.53762*height))
                    path.addCurve(to: CGPoint(x: 0.60394*width, y: 0.55951*height), control1: CGPoint(x: 0.59704*width, y: 0.53307*height), control2: CGPoint(x: 0.60069*width, y: 0.54574*height))
                    path.addCurve(to: CGPoint(x: 0.59331*width, y: 0.65181*height), control1: CGPoint(x: 0.60843*width, y: 0.57863*height), control2: CGPoint(x: 0.60817*width, y: 0.59883*height))
                    path.addCurve(to: CGPoint(x: 0.57049*width, y: 0.64417*height), control1: CGPoint(x: 0.59164*width, y: 0.65775*height), control2: CGPoint(x: 0.5744*width, y: 0.65026*height))
                    path.addCurve(to: CGPoint(x: 0.56565*width, y: 0.62923*height), control1: CGPoint(x: 0.56792*width, y: 0.64008*height), control2: CGPoint(x: 0.56595*width, y: 0.6337*height))
                    path.addCurve(to: CGPoint(x: 0.56836*width, y: 0.61106*height), control1: CGPoint(x: 0.56565*width, y: 0.62921*height), control2: CGPoint(x: 0.56616*width, y: 0.61804*height))
                    path.closeSubpath()
                    return path
                }
            }

            struct VastusMedialis: Shape {
                func path(in rect: CGRect) -> Path {
                    var path = Path()
                    let width = rect.size.width
                    let height = rect.size.height
                    path.move(to: CGPoint(x: 0.46185*width, y: 0.60852*height))
                    path.addCurve(to: CGPoint(x: 0.45581*width, y: 0.57633*height), control1: CGPoint(x: 0.46095*width, y: 0.59699*height), control2: CGPoint(x: 0.45905*width, y: 0.58772*height))
                    path.addCurve(to: CGPoint(x: 0.44382*width, y: 0.55108*height), control1: CGPoint(x: 0.45343*width, y: 0.56796*height), control2: CGPoint(x: 0.44882*width, y: 0.55886*height))
                    path.addCurve(to: CGPoint(x: 0.41053*width, y: 0.60557*height), control1: CGPoint(x: 0.43581*width, y: 0.56958*height), control2: CGPoint(x: 0.41697*width, y: 0.58674*height))
                    path.addCurve(to: CGPoint(x: 0.41481*width, y: 0.63674*height), control1: CGPoint(x: 0.40704*width, y: 0.61583*height), control2: CGPoint(x: 0.40674*width, y: 0.62724*height))
                    path.addCurve(to: CGPoint(x: 0.45676*width, y: 0.64867*height), control1: CGPoint(x: 0.42229*width, y: 0.64552*height), control2: CGPoint(x: 0.44174*width, y: 0.65654*height))
                    path.addCurve(to: CGPoint(x: 0.46215*width, y: 0.61069*height), control1: CGPoint(x: 0.45789*width, y: 0.64253*height), control2: CGPoint(x: 0.4615*width, y: 0.61535*height))
                    path.addLine(to: CGPoint(x: 0.46185*width, y: 0.60852*height))
                    path.closeSubpath()
                    path.move(to: CGPoint(x: 0.50847*width, y: 0.61094*height))
                    path.addCurve(to: CGPoint(x: 0.51074*width, y: 0.62457*height), control1: CGPoint(x: 0.5088*width, y: 0.61562*height), control2: CGPoint(x: 0.51016*width, y: 0.62012*height))
                    path.addCurve(to: CGPoint(x: 0.5141*width, y: 0.64836*height), control1: CGPoint(x: 0.51187*width, y: 0.6336*height), control2: CGPoint(x: 0.51296*width, y: 0.64224*height))
                    path.addCurve(to: CGPoint(x: 0.55519*width, y: 0.63674*height), control1: CGPoint(x: 0.5291*width, y: 0.65623*height), control2: CGPoint(x: 0.54771*width, y: 0.64552*height))
                    path.addCurve(to: CGPoint(x: 0.55965*width, y: 0.60554*height), control1: CGPoint(x: 0.56326*width, y: 0.62724*height), control2: CGPoint(x: 0.56315*width, y: 0.6158*height))
                    path.addCurve(to: CGPoint(x: 0.52623*width, y: 0.55103*height), control1: CGPoint(x: 0.55322*width, y: 0.5867*height), control2: CGPoint(x: 0.53162*width, y: 0.5625*height))
                    path.addCurve(to: CGPoint(x: 0.50847*width, y: 0.61094*height), control1: CGPoint(x: 0.51748*width, y: 0.55989*height), control2: CGPoint(x: 0.50715*width, y: 0.59167*height))
                    path.closeSubpath()
                    return path.offsetBy(dx: -0.0035*width, dy: 0)
                }
            }
        }

        struct Deltoids: Shape {
            func path(in rect: CGRect) -> Path {
                var path = Path()
                path.addPath(Deltoids().path(in: rect))
                return path
                    .offsetBy(dx: 0.04675 * rect.size.width, dy: 0)
            }

            struct Deltoids: Shape {
                func path(in rect: CGRect) -> Path {
                    var path = Path()
                    let width = rect.size.width
                    let height = rect.size.height
                    path.move(to: CGPoint(x: 0.36227*width, y: 0.25861*height))
                    path.addCurve(to: CGPoint(x: 0.35424*width, y: 0.26795*height), control1: CGPoint(x: 0.36079*width, y: 0.26196*height), control2: CGPoint(x: 0.3578*width, y: 0.26512*height))
                    path.addCurve(to: CGPoint(x: 0.34729*width, y: 0.27289*height), control1: CGPoint(x: 0.35174*width, y: 0.26949*height), control2: CGPoint(x: 0.3494*width, y: 0.27114*height))
                    path.addLine(to: CGPoint(x: 0.34657*width, y: 0.27352*height))
                    path.addCurve(to: CGPoint(x: 0.33597*width, y: 0.28927*height), control1: CGPoint(x: 0.34127*width, y: 0.27807*height), control2: CGPoint(x: 0.33752*width, y: 0.28333*height))
                    path.addLine(to: CGPoint(x: 0.33595*width, y: 0.28931*height))
                    path.addCurve(to: CGPoint(x: 0.31812*width, y: 0.30517*height), control1: CGPoint(x: 0.3316*width, y: 0.29545*height), control2: CGPoint(x: 0.32567*width, y: 0.30066*height))
                    path.addCurve(to: CGPoint(x: 0.30319*width, y: 0.31164*height), control1: CGPoint(x: 0.31368*width, y: 0.30782*height), control2: CGPoint(x: 0.3085*width, y: 0.30986*height))
                    path.addCurve(to: CGPoint(x: 0.28803*width, y: 0.31009*height), control1: CGPoint(x: 0.2956*width, y: 0.31417*height), control2: CGPoint(x: 0.29264*width, y: 0.31394*height))
                    path.addCurve(to: CGPoint(x: 0.28241*width, y: 0.29477*height), control1: CGPoint(x: 0.2875*width, y: 0.30904*height), control2: CGPoint(x: 0.28426*width, y: 0.30265*height))
                    path.addCurve(to: CGPoint(x: 0.29449*width, y: 0.25495*height), control1: CGPoint(x: 0.28039*width, y: 0.28616*height), control2: CGPoint(x: 0.28914*width, y: 0.26401*height))
                    path.addCurve(to: CGPoint(x: 0.31044*width, y: 0.24556*height), control1: CGPoint(x: 0.29775*width, y: 0.24944*height), control2: CGPoint(x: 0.30449*width, y: 0.24738*height))
                    path.addCurve(to: CGPoint(x: 0.31611*width, y: 0.24363*height), control1: CGPoint(x: 0.31248*width, y: 0.24494*height), control2: CGPoint(x: 0.31444*width, y: 0.24434*height))
                    path.addCurve(to: CGPoint(x: 0.34387*width, y: 0.24785*height), control1: CGPoint(x: 0.32069*width, y: 0.24968*height), control2: CGPoint(x: 0.33579*width, y: 0.24819*height))
                    path.addCurve(to: CGPoint(x: 0.36227*width, y: 0.25861*height), control1: CGPoint(x: 0.35484*width, y: 0.24739*height), control2: CGPoint(x: 0.36639*width, y: 0.24926*height))
                    path.move(to: CGPoint(x: 0.54262*width, y: 0.25725*height))
                    path.addCurve(to: CGPoint(x: 0.56227*width, y: 0.24727*height), control1: CGPoint(x: 0.53979*width, y: 0.24769*height), control2: CGPoint(x: 0.55127*width, y: 0.24682*height))
                    path.addCurve(to: CGPoint(x: 0.58949*width, y: 0.24343*height), control1: CGPoint(x: 0.57035*width, y: 0.24761*height), control2: CGPoint(x: 0.58491*width, y: 0.24949*height))
                    path.addCurve(to: CGPoint(x: 0.59549*width, y: 0.2456*height), control1: CGPoint(x: 0.59116*width, y: 0.24414*height), control2: CGPoint(x: 0.59343*width, y: 0.24498*height))
                    path.addCurve(to: CGPoint(x: 0.61164*width, y: 0.25565*height), control1: CGPoint(x: 0.60144*width, y: 0.24744*height), control2: CGPoint(x: 0.60838*width, y: 0.25014*height))
                    path.addCurve(to: CGPoint(x: 0.62384*width, y: 0.29491*height), control1: CGPoint(x: 0.61699*width, y: 0.26471*height), control2: CGPoint(x: 0.62586*width, y: 0.2863*height))
                    path.addCurve(to: CGPoint(x: 0.61817*width, y: 0.31019*height), control1: CGPoint(x: 0.62201*width, y: 0.30279*height), control2: CGPoint(x: 0.61873*width, y: 0.30914*height))
                    path.addCurve(to: CGPoint(x: 0.6025*width, y: 0.31162*height), control1: CGPoint(x: 0.61356*width, y: 0.31401*height), control2: CGPoint(x: 0.61009*width, y: 0.31417*height))
                    path.addCurve(to: CGPoint(x: 0.58757*width, y: 0.30515*height), control1: CGPoint(x: 0.5972*width, y: 0.30985*height), control2: CGPoint(x: 0.59201*width, y: 0.30781*height))
                    path.addCurve(to: CGPoint(x: 0.56975*width, y: 0.28929*height), control1: CGPoint(x: 0.58002*width, y: 0.30065*height), control2: CGPoint(x: 0.57407*width, y: 0.29545*height))
                    path.addLine(to: CGPoint(x: 0.56972*width, y: 0.28926*height))
                    path.addCurve(to: CGPoint(x: 0.55912*width, y: 0.2735*height), control1: CGPoint(x: 0.56817*width, y: 0.28332*height), control2: CGPoint(x: 0.56442*width, y: 0.27806*height))
                    path.addCurve(to: CGPoint(x: 0.55176*width, y: 0.26748*height), control1: CGPoint(x: 0.55912*width, y: 0.2735*height), control2: CGPoint(x: 0.55426*width, y: 0.26903*height))
                    path.addCurve(to: CGPoint(x: 0.54262*width, y: 0.25725*height), control1: CGPoint(x: 0.54819*width, y: 0.26468*height), control2: CGPoint(x: 0.54414*width, y: 0.26244*height))
                    path.closeSubpath()
                    return path
                }
            }
        }

        struct Trapezii: Shape {
            func path(in rect: CGRect) -> Path {
                var path = Path()
                path.addPath(Trapezius().path(in: rect))
                return path.offsetBy(dx: 0.04675 * rect.size.width, dy: 0)
            }

            struct Trapezius: Shape {
                func path(in rect: CGRect) -> Path {
                    var path = Path()
                    let width = rect.size.width
                    let height = rect.size.height
                    path.move(to: CGPoint(x: 0.48843*width, y: 0.21068*height))
                    path.addLine(to: CGPoint(x: 0.48843*width, y: 0.21069*height))
                    path.addCurve(to: CGPoint(x: 0.51062*width, y: 0.23367*height), control1: CGPoint(x: 0.49856*width, y: 0.21671*height), control2: CGPoint(x: 0.50343*width, y: 0.22617*height))
                    path.addCurve(to: CGPoint(x: 0.57296*width, y: 0.23688*height), control1: CGPoint(x: 0.52519*width, y: 0.24887*height), control2: CGPoint(x: 0.55227*width, y: 0.23907*height))
                    path.addCurve(to: CGPoint(x: 0.56822*width, y: 0.23452*height), control1: CGPoint(x: 0.5719*width, y: 0.2364*height), control2: CGPoint(x: 0.56951*width, y: 0.23529*height))
                    path.addCurve(to: CGPoint(x: 0.5506*width, y: 0.22603*height), control1: CGPoint(x: 0.56516*width, y: 0.23265*height), control2: CGPoint(x: 0.56053*width, y: 0.22986*height))
                    path.addCurve(to: CGPoint(x: 0.52822*width, y: 0.21841*height), control1: CGPoint(x: 0.54512*width, y: 0.2239*height), control2: CGPoint(x: 0.53648*width, y: 0.22106*height))
                    path.addCurve(to: CGPoint(x: 0.49553*width, y: 0.2058*height), control1: CGPoint(x: 0.5137*width, y: 0.21378*height), control2: CGPoint(x: 0.49968*width, y: 0.2092*height))
                    path.addCurve(to: CGPoint(x: 0.49213*width, y: 0.19884*height), control1: CGPoint(x: 0.49387*width, y: 0.20444*height), control2: CGPoint(x: 0.49287*width, y: 0.20137*height))
                    path.addCurve(to: CGPoint(x: 0.4912*width, y: 0.1985*height), control1: CGPoint(x: 0.49208*width, y: 0.19869*height), control2: CGPoint(x: 0.49125*width, y: 0.19866*height))
                    path.addCurve(to: CGPoint(x: 0.48843*width, y: 0.21068*height), control1: CGPoint(x: 0.49067*width, y: 0.20108*height), control2: CGPoint(x: 0.48958*width, y: 0.2066*height))
                    path.move(to: CGPoint(x: 0.41722*width, y: 0.20988*height))
                    path.addCurve(to: CGPoint(x: 0.41444*width, y: 0.19909*height), control1: CGPoint(x: 0.41606*width, y: 0.2058*height), control2: CGPoint(x: 0.41495*width, y: 0.20167*height))
                    path.addCurve(to: CGPoint(x: 0.40963*width, y: 0.20665*height), control1: CGPoint(x: 0.41373*width, y: 0.20167*height), control2: CGPoint(x: 0.41139*width, y: 0.2052*height))
                    path.addCurve(to: CGPoint(x: 0.3766*width, y: 0.21873*height), control1: CGPoint(x: 0.40549*width, y: 0.21005*height), control2: CGPoint(x: 0.39111*width, y: 0.2141*height))
                    path.addCurve(to: CGPoint(x: 0.35507*width, y: 0.226*height), control1: CGPoint(x: 0.36833*width, y: 0.22137*height), control2: CGPoint(x: 0.36056*width, y: 0.22387*height))
                    path.addCurve(to: CGPoint(x: 0.33507*width, y: 0.23498*height), control1: CGPoint(x: 0.34514*width, y: 0.22983*height), control2: CGPoint(x: 0.33813*width, y: 0.23312*height))
                    path.addCurve(to: CGPoint(x: 0.33144*width, y: 0.23702*height), control1: CGPoint(x: 0.33377*width, y: 0.23576*height), control2: CGPoint(x: 0.3325*width, y: 0.23654*height))
                    path.addCurve(to: CGPoint(x: 0.39458*width, y: 0.23403*height), control1: CGPoint(x: 0.35213*width, y: 0.23921*height), control2: CGPoint(x: 0.38002*width, y: 0.24923*height))
                    path.addCurve(to: CGPoint(x: 0.41745*width, y: 0.21069*height), control1: CGPoint(x: 0.40178*width, y: 0.22654*height), control2: CGPoint(x: 0.40731*width, y: 0.21671*height))
                    path.addLine(to: CGPoint(x: 0.41722*width, y: 0.20988*height))
                    path.closeSubpath()
                    return path
                }
            }
        }

        struct Triceps: Shape {
            func path(in rect: CGRect) -> Path {
                var path = Path()
                path.addPath(TricepsBrachiiLongHead().path(in: rect))
                path.addPath(TricepsBrachiiMedialHead().path(in: rect))
                return path.offsetBy(dx: 0.04675 * rect.size.width, dy: 0)
            }

            struct TricepsBrachiiLongHead: Shape {
                func path(in rect: CGRect) -> Path {
                    var path = Path()
                    let width = rect.size.width
                    let height = rect.size.height
                    path.move(to: CGPoint(x: 0.55699*width, y: 0.30458*height))
                    path.addCurve(to: CGPoint(x: 0.61088*width, y: 0.39458*height), control1: CGPoint(x: 0.55699*width, y: 0.30458*height), control2: CGPoint(x: 0.56847*width, y: 0.36897*height))
                    path.addCurve(to: CGPoint(x: 0.60275*width, y: 0.4063*height), control1: CGPoint(x: 0.6113*width, y: 0.39531*height), control2: CGPoint(x: 0.60275*width, y: 0.4063*height))
                    path.addCurve(to: CGPoint(x: 0.58831*width, y: 0.3967*height), control1: CGPoint(x: 0.60275*width, y: 0.4063*height), control2: CGPoint(x: 0.59245*width, y: 0.39867*height))
                    path.addCurve(to: CGPoint(x: 0.57935*width, y: 0.3744*height), control1: CGPoint(x: 0.58127*width, y: 0.39335*height), control2: CGPoint(x: 0.57859*width, y: 0.39352*height))
                    path.addCurve(to: CGPoint(x: 0.57127*width, y: 0.35309*height), control1: CGPoint(x: 0.57859*width, y: 0.37054*height), control2: CGPoint(x: 0.57569*width, y: 0.35784*height))
                    path.addCurve(to: CGPoint(x: 0.55144*width, y: 0.32651*height), control1: CGPoint(x: 0.56685*width, y: 0.34833*height), control2: CGPoint(x: 0.55144*width, y: 0.32651*height))
                    path.addLine(to: CGPoint(x: 0.55451*width, y: 0.3065*height))
                    path.addLine(to: CGPoint(x: 0.55699*width, y: 0.30458*height))
                    path.closeSubpath()
                    path.move(to: CGPoint(x: 0.34977*width, y: 0.30483*height))
                    path.addCurve(to: CGPoint(x: 0.29588*width, y: 0.39529*height), control1: CGPoint(x: 0.34977*width, y: 0.30483*height), control2: CGPoint(x: 0.33826*width, y: 0.36968*height))
                    path.addCurve(to: CGPoint(x: 0.30359*width, y: 0.40639*height), control1: CGPoint(x: 0.29546*width, y: 0.39602*height), control2: CGPoint(x: 0.30359*width, y: 0.40639*height))
                    path.addLine(to: CGPoint(x: 0.31796*width, y: 0.39738*height))
                    path.addCurve(to: CGPoint(x: 0.32697*width, y: 0.37449*height), control1: CGPoint(x: 0.31796*width, y: 0.39738*height), control2: CGPoint(x: 0.32773*width, y: 0.39361*height))
                    path.addCurve(to: CGPoint(x: 0.33505*width, y: 0.35318*height), control1: CGPoint(x: 0.32773*width, y: 0.37063*height), control2: CGPoint(x: 0.33063*width, y: 0.35793*height))
                    path.addCurve(to: CGPoint(x: 0.35488*width, y: 0.3266*height), control1: CGPoint(x: 0.33947*width, y: 0.34843*height), control2: CGPoint(x: 0.35488*width, y: 0.3266*height))
                    path.addLine(to: CGPoint(x: 0.35181*width, y: 0.30659*height))
                    path.addLine(to: CGPoint(x: 0.34977*width, y: 0.30483*height))
                    path.closeSubpath()
                    return path
                }
            }

            struct TricepsBrachiiMedialHead: Shape {
                func path(in rect: CGRect) -> Path {
                    var path = Path()
                    let width = rect.size.width
                    let height = rect.size.height
                    path.move(to: CGPoint(x: 0.27037*width, y: 0.36168*height))
                    path.addCurve(to: CGPoint(x: 0.26718*width, y: 0.32301*height), control1: CGPoint(x: 0.26477*width, y: 0.34596*height), control2: CGPoint(x: 0.26678*width, y: 0.33526*height))
                    path.addCurve(to: CGPoint(x: 0.28063*width, y: 0.2958*height), control1: CGPoint(x: 0.26769*width, y: 0.30691*height), control2: CGPoint(x: 0.26738*width, y: 0.30889*height))
                    path.addCurve(to: CGPoint(x: 0.28586*width, y: 0.31025*height), control1: CGPoint(x: 0.28132*width, y: 0.29975*height), control2: CGPoint(x: 0.28586*width, y: 0.31025*height))
                    path.addCurve(to: CGPoint(x: 0.27329*width, y: 0.35846*height), control1: CGPoint(x: 0.28586*width, y: 0.31025*height), control2: CGPoint(x: 0.276*width, y: 0.32546*height))
                    path.addCurve(to: CGPoint(x: 0.27037*width, y: 0.36168*height), control1: CGPoint(x: 0.27289*width, y: 0.35884*height), control2: CGPoint(x: 0.27037*width, y: 0.36168*height))
                    path.closeSubpath()
                    path.move(to: CGPoint(x: 0.63537*width, y: 0.36187*height))
                    path.addCurve(to: CGPoint(x: 0.63856*width, y: 0.32319*height), control1: CGPoint(x: 0.64097*width, y: 0.34614*height), control2: CGPoint(x: 0.63896*width, y: 0.33545*height))
                    path.addCurve(to: CGPoint(x: 0.62512*width, y: 0.29599*height), control1: CGPoint(x: 0.63806*width, y: 0.3071*height), control2: CGPoint(x: 0.63836*width, y: 0.30907*height))
                    path.addCurve(to: CGPoint(x: 0.61975*width, y: 0.30992*height), control1: CGPoint(x: 0.62442*width, y: 0.29994*height), control2: CGPoint(x: 0.61975*width, y: 0.30992*height))
                    path.addCurve(to: CGPoint(x: 0.63248*width, y: 0.35864*height), control1: CGPoint(x: 0.61975*width, y: 0.30992*height), control2: CGPoint(x: 0.62977*width, y: 0.32565*height))
                    path.addCurve(to: CGPoint(x: 0.63537*width, y: 0.36187*height), control1: CGPoint(x: 0.63287*width, y: 0.35903*height), control2: CGPoint(x: 0.63537*width, y: 0.36187*height))
                    path.closeSubpath()
                    return path
                }
            }
        }
    }
}

#if DEBUG
#Preview {
    MusculoDiagramsView.AnteriorCoronal(presenting: [
        .abdominals { print("abdominals") },
        .abductors { print("abductors") },
        .adductors { print("adductors") },
        .biceps { print("biceps") },
        .calves { print("calves") },
        .deltoids { print("deltoids") },
        .forearms { print("forearms") },
        .glutes { print("glutes") },
        .hamstrings { print("hamstrings") },
        .laterals { print("laterals") },
        .lumbars { print("lumbars") },
        // .neck { print("neck") },
        .obliques { print("obliques") },
        .pectorals { print("pectorals") },
        .quadriceps { print("quads") },
        .trapezii { print("trapezii") },
        .triceps { print("triceps") },
    ])
}
#endif
