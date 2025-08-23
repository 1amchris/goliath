//
//  MusculoDiagrams.swift
//  goliath
//
//  Created by Christophe Beaulieu on 2025-08-19.
//

import SwiftUI

extension MusculoDiagramsView.MuscleGroup {
    init(fromMuscleWith id: MuscleGroup.ID, perform action: (() -> Void)? = nil) throws {
        self = switch MuscleGroup.Supported(rawValue: id) {
        case .abdominals: .abdominals(action: action)
        case .abductors: .abductors(action: action)
        case .adductors: .adductors(action: action)
        case .biceps: .biceps(action: action)
        case .calves: .calves(action: action)
        case .deltoids: .deltoids(action: action)
        case .forearms: .forearms(action: action)
        case .glutes: .glutes(action: action)
        case .hamstrings: .hamstrings(action: action)
        case .laterals: .laterals(action: action)
        case .lumbars: .lumbars(action: action)
        case .neck: .neck(action: action)
        case .obliques: .obliques(action: action)
        case .pectorals: .pectorals(action: action)
        case .quadriceps: .quadriceps(action: action)
        case .trapezii: .trapezii(action: action)
        case .triceps: .triceps(action: action)
            
        case .none: throw AppError.keyNotFound(key: id)
        }
    }
}

struct ColoredDisabledButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(Color.accentColor.saturation(0.5))
    }
}

struct MusculoDiagramsView {
    static let coronalAspectRatio: CGFloat = 7/20
    static let bodyAspectRatio: CGFloat = 432/648
    static let bodyScalingFactor = 2.4

    @ViewBuilder
    static func draw<S: Shape>(
        muscleGroup shape: S,
        disabled: Bool? = nil,
        onTapPerform action: (() -> Void)?
    ) -> some View {
        let base = Button {
            action?()
        } label: {
            shape
        }
        .contentShape(shape)
        .disabled(disabled ?? false)
        
        if disabled != true, action == nil {
            base
                .allowsHitTesting(false)
                .tint(Color.accentColor)
                .opacity(0.4)
        } else {
            base
                .buttonStyle(.borderless)
        }
    }

    public enum MuscleGroup: CaseIterable, Equatable, Hashable {
        static var allCases: [Self] {
            return [
                .abdominals(disabled: true),
                .abductors(disabled: true),
                .adductors(disabled: true),
                .biceps(disabled: true),
                .calves(disabled: true),
                .forearms(disabled: true),
                .glutes(disabled: true),
                .hamstrings(disabled: true),
                .laterals(disabled: true),
                .lumbars(disabled: true),
                .neck(disabled: true),
                .obliques(disabled: true),
                .pectorals(disabled: true),
                .quadriceps(disabled: true),
                .deltoids(disabled: true),
                .trapezii(disabled: true),
                .triceps(disabled: true),
            ]
        }
        
        static func == (lhs: Self, rhs: Self) -> Bool {
            lhs.hashValue == rhs.hashValue
        }
        
        func hash(into hasher: inout Hasher) {
            switch self {
            case .abdominals: hasher.combine("abdominals")
            case .abductors: hasher.combine("abductors")
            case .adductors: hasher.combine("adductors")
            case .biceps: hasher.combine("biceps")
            case .calves: hasher.combine("calves")
            case .deltoids: hasher.combine("deltoids")
            case .forearms: hasher.combine("forearms")
            case .glutes: hasher.combine("glutes")
            case .hamstrings: hasher.combine("hamstrings")
            case .laterals: hasher.combine("laterals")
            case .lumbars: hasher.combine("lumbars")
            case .neck: hasher.combine("neck")
            case .obliques: hasher.combine("obliques")
            case .pectorals: hasher.combine("pectorals")
            case .quadriceps: hasher.combine("quadriceps")
            case .trapezii: hasher.combine("trapezii")
            case .triceps: hasher.combine("triceps")
            }
        }
        
        case abdominals(disabled: Bool? = nil, action: (() -> Void)? = nil)
        case abductors(disabled: Bool? = nil, action: (() -> Void)? = nil)
        case adductors(disabled: Bool? = nil, action: (() -> Void)? = nil)
        case biceps(disabled: Bool? = nil, action: (() -> Void)? = nil)
        case calves(disabled: Bool? = nil, action: (() -> Void)? = nil)
        case forearms(disabled: Bool? = nil, action: (() -> Void)? = nil)
        case glutes(disabled: Bool? = nil, action: (() -> Void)? = nil)
        case hamstrings(disabled: Bool? = nil, action: (() -> Void)? = nil)
        case laterals(disabled: Bool? = nil, action: (() -> Void)? = nil)
        case lumbars(disabled: Bool? = nil, action: (() -> Void)? = nil)
        case neck(disabled: Bool? = nil, action: (() -> Void)? = nil)
        case obliques(disabled: Bool? = nil, action: (() -> Void)? = nil)
        case pectorals(disabled: Bool? = nil, action: (() -> Void)? = nil)
        case quadriceps(disabled: Bool? = nil, action: (() -> Void)? = nil)
        case deltoids(disabled: Bool? = nil, action: (() -> Void)? = nil)
        case trapezii(disabled: Bool? = nil, action: (() -> Void)? = nil)
        case triceps(disabled: Bool? = nil, action: (() -> Void)? = nil)
    }

    struct Body: View {
        var body: some View {
            Outline()
                .fill(LinearGradient(
                    colors: [.gray.opacity(0.15), .gray.opacity(0.15)],
                    startPoint: .top, endPoint: .bottom))
        }
        
        struct Outline: Shape {
            func path(in rect: CGRect) -> Path {
                var path = Path()
                let width = rect.size.width
                let height = rect.size.height
                path.move(to: CGPoint(x: 0.6435*width, y: 0.40187*height))
                path.addLine(to: CGPoint(x: 0.6435*width, y: 0.38873*height))
                path.addCurve(to: CGPoint(x: 0.63069*width, y: 0.36375*height), control1: CGPoint(x: 0.6435*width, y: 0.37924*height), control2: CGPoint(x: 0.6356*width, y: 0.36914*height))
                path.addCurve(to: CGPoint(x: 0.63296*width, y: 0.31491*height), control1: CGPoint(x: 0.63556*width, y: 0.35292*height), control2: CGPoint(x: 0.6356*width, y: 0.32696*height))
                path.addCurve(to: CGPoint(x: 0.61993*width, y: 0.29779*height), control1: CGPoint(x: 0.63134*width, y: 0.30759*height), control2: CGPoint(x: 0.6237*width, y: 0.30162*height))
                path.addCurve(to: CGPoint(x: 0.62014*width, y: 0.29691*height), control1: CGPoint(x: 0.62*width, y: 0.2975*height), control2: CGPoint(x: 0.62007*width, y: 0.29721*height))
                path.addCurve(to: CGPoint(x: 0.6078*width, y: 0.25721*height), control1: CGPoint(x: 0.62222*width, y: 0.28807*height), control2: CGPoint(x: 0.61319*width, y: 0.26636*height))
                path.addCurve(to: CGPoint(x: 0.59069*width, y: 0.24698*height), control1: CGPoint(x: 0.60421*width, y: 0.25113*height), control2: CGPoint(x: 0.59671*width, y: 0.24883*height))
                path.addCurve(to: CGPoint(x: 0.58303*width, y: 0.24387*height), control1: CGPoint(x: 0.58743*width, y: 0.24597*height), control2: CGPoint(x: 0.58463*width, y: 0.24511*height))
                path.addCurve(to: CGPoint(x: 0.57137*width, y: 0.23909*height), control1: CGPoint(x: 0.57898*width, y: 0.24071*height), control2: CGPoint(x: 0.57493*width, y: 0.23985*height))
                path.addCurve(to: CGPoint(x: 0.56866*width, y: 0.23846*height), control1: CGPoint(x: 0.57042*width, y: 0.23889*height), control2: CGPoint(x: 0.56951*width, y: 0.2387*height))
                path.addCurve(to: CGPoint(x: 0.56424*width, y: 0.23625*height), control1: CGPoint(x: 0.56729*width, y: 0.23809*height), control2: CGPoint(x: 0.56606*width, y: 0.23736*height))
                path.addCurve(to: CGPoint(x: 0.54632*width, y: 0.22761*height), control1: CGPoint(x: 0.56111*width, y: 0.23435*height), control2: CGPoint(x: 0.55639*width, y: 0.2315*height))
                path.addCurve(to: CGPoint(x: 0.52472*width, y: 0.22034*height), control1: CGPoint(x: 0.54079*width, y: 0.22546*height), control2: CGPoint(x: 0.53299*width, y: 0.22298*height))
                path.addCurve(to: CGPoint(x: 0.49164*width, y: 0.20795*height), control1: CGPoint(x: 0.5112*width, y: 0.21602*height), control2: CGPoint(x: 0.49542*width, y: 0.21105*height))
                path.addCurve(to: CGPoint(x: 0.4878*width, y: 0.19324*height), control1: CGPoint(x: 0.48822*width, y: 0.20512*height), control2: CGPoint(x: 0.48785*width, y: 0.19619*height))
                path.addCurve(to: CGPoint(x: 0.48956*width, y: 0.18358*height), control1: CGPoint(x: 0.48942*width, y: 0.19048*height), control2: CGPoint(x: 0.48961*width, y: 0.18611*height))
                path.addCurve(to: CGPoint(x: 0.49206*width, y: 0.18383*height), control1: CGPoint(x: 0.49023*width, y: 0.1838*height), control2: CGPoint(x: 0.49106*width, y: 0.1839*height))
                path.addCurve(to: CGPoint(x: 0.50236*width, y: 0.17551*height), control1: CGPoint(x: 0.49544*width, y: 0.18355*height), control2: CGPoint(x: 0.49859*width, y: 0.18006*height))
                path.addCurve(to: CGPoint(x: 0.50519*width, y: 0.1723*height), control1: CGPoint(x: 0.50343*width, y: 0.17423*height), control2: CGPoint(x: 0.50442*width, y: 0.17302*height))
                path.addCurve(to: CGPoint(x: 0.50535*width, y: 0.15739*height), control1: CGPoint(x: 0.50845*width, y: 0.16918*height), control2: CGPoint(x: 0.50773*width, y: 0.16244*height))
                path.addCurve(to: CGPoint(x: 0.50183*width, y: 0.15486*height), control1: CGPoint(x: 0.50465*width, y: 0.15593*height), control2: CGPoint(x: 0.50347*width, y: 0.15506*height))
                path.addCurve(to: CGPoint(x: 0.49535*width, y: 0.15681*height), control1: CGPoint(x: 0.49958*width, y: 0.1546*height), control2: CGPoint(x: 0.49711*width, y: 0.15573*height))
                path.addCurve(to: CGPoint(x: 0.48465*width, y: 0.12409*height), control1: CGPoint(x: 0.49567*width, y: 0.15051*height), control2: CGPoint(x: 0.49556*width, y: 0.13281*height))
                path.addCurve(to: CGPoint(x: 0.44938*width, y: 0.11427*height), control1: CGPoint(x: 0.47528*width, y: 0.11659*height), control2: CGPoint(x: 0.4565*width, y: 0.11472*height))
                path.addLine(to: CGPoint(x: 0.44657*width, y: 0.11427*height))
                path.addCurve(to: CGPoint(x: 0.4113*width, y: 0.12409*height), control1: CGPoint(x: 0.43947*width, y: 0.11472*height), control2: CGPoint(x: 0.42069*width, y: 0.11659*height))
                path.addCurve(to: CGPoint(x: 0.4006*width, y: 0.15681*height), control1: CGPoint(x: 0.40039*width, y: 0.13281*height), control2: CGPoint(x: 0.40028*width, y: 0.15051*height))
                path.addCurve(to: CGPoint(x: 0.39412*width, y: 0.15486*height), control1: CGPoint(x: 0.39884*width, y: 0.15573*height), control2: CGPoint(x: 0.39637*width, y: 0.15458*height))
                path.addCurve(to: CGPoint(x: 0.3906*width, y: 0.15739*height), control1: CGPoint(x: 0.39248*width, y: 0.15506*height), control2: CGPoint(x: 0.3913*width, y: 0.15591*height))
                path.addCurve(to: CGPoint(x: 0.39076*width, y: 0.1723*height), control1: CGPoint(x: 0.38822*width, y: 0.16244*height), control2: CGPoint(x: 0.3875*width, y: 0.16918*height))
                path.addCurve(to: CGPoint(x: 0.39359*width, y: 0.17551*height), control1: CGPoint(x: 0.39153*width, y: 0.17302*height), control2: CGPoint(x: 0.39252*width, y: 0.17423*height))
                path.addCurve(to: CGPoint(x: 0.40389*width, y: 0.18383*height), control1: CGPoint(x: 0.39736*width, y: 0.18006*height), control2: CGPoint(x: 0.40053*width, y: 0.18355*height))
                path.addCurve(to: CGPoint(x: 0.40639*width, y: 0.18358*height), control1: CGPoint(x: 0.40488*width, y: 0.1839*height), control2: CGPoint(x: 0.40572*width, y: 0.1838*height))
                path.addCurve(to: CGPoint(x: 0.40868*width, y: 0.19404*height), control1: CGPoint(x: 0.40632*width, y: 0.18637*height), control2: CGPoint(x: 0.40655*width, y: 0.19139*height))
                path.addCurve(to: CGPoint(x: 0.4087*width, y: 0.19406*height), control1: CGPoint(x: 0.40868*width, y: 0.19404*height), control2: CGPoint(x: 0.40868*width, y: 0.19406*height))
                path.addCurve(to: CGPoint(x: 0.40433*width, y: 0.20801*height), control1: CGPoint(x: 0.40861*width, y: 0.19613*height), control2: CGPoint(x: 0.40796*width, y: 0.20502*height))
                path.addCurve(to: CGPoint(x: 0.37171*width, y: 0.22032*height), control1: CGPoint(x: 0.40056*width, y: 0.21111*height), control2: CGPoint(x: 0.38523*width, y: 0.216*height))
                path.addCurve(to: CGPoint(x: 0.35012*width, y: 0.22759*height), control1: CGPoint(x: 0.36345*width, y: 0.22296*height), control2: CGPoint(x: 0.35565*width, y: 0.22545*height))
                path.addCurve(to: CGPoint(x: 0.3322*width, y: 0.23623*height), control1: CGPoint(x: 0.34002*width, y: 0.2315*height), control2: CGPoint(x: 0.3353*width, y: 0.23435*height))
                path.addCurve(to: CGPoint(x: 0.32778*width, y: 0.23844*height), control1: CGPoint(x: 0.33037*width, y: 0.23735*height), control2: CGPoint(x: 0.32914*width, y: 0.23809*height))
                path.addCurve(to: CGPoint(x: 0.32507*width, y: 0.23907*height), control1: CGPoint(x: 0.3269*width, y: 0.23867*height), control2: CGPoint(x: 0.326*width, y: 0.23887*height))
                path.addCurve(to: CGPoint(x: 0.3134*width, y: 0.24386*height), control1: CGPoint(x: 0.3215*width, y: 0.23983*height), control2: CGPoint(x: 0.31745*width, y: 0.24069*height))
                path.addCurve(to: CGPoint(x: 0.30574*width, y: 0.24696*height), control1: CGPoint(x: 0.31181*width, y: 0.24509*height), control2: CGPoint(x: 0.309*width, y: 0.24596*height))
                path.addCurve(to: CGPoint(x: 0.28863*width, y: 0.25719*height), control1: CGPoint(x: 0.29972*width, y: 0.24881*height), control2: CGPoint(x: 0.29222*width, y: 0.25111*height))
                path.addCurve(to: CGPoint(x: 0.2763*width, y: 0.2969*height), control1: CGPoint(x: 0.28322*width, y: 0.26634*height), control2: CGPoint(x: 0.27421*width, y: 0.28806*height))
                path.addCurve(to: CGPoint(x: 0.27676*width, y: 0.29877*height), control1: CGPoint(x: 0.27644*width, y: 0.29753*height), control2: CGPoint(x: 0.2766*width, y: 0.29815*height))
                path.addCurve(to: CGPoint(x: 0.26449*width, y: 0.31523*height), control1: CGPoint(x: 0.27294*width, y: 0.30256*height), control2: CGPoint(x: 0.26606*width, y: 0.30809*height))
                path.addCurve(to: CGPoint(x: 0.26632*width, y: 0.36309*height), control1: CGPoint(x: 0.26185*width, y: 0.32721*height), control2: CGPoint(x: 0.26157*width, y: 0.35216*height))
                path.addCurve(to: CGPoint(x: 0.25292*width, y: 0.3887*height), control1: CGPoint(x: 0.26148*width, y: 0.36827*height), control2: CGPoint(x: 0.25292*width, y: 0.37883*height))
                path.addLine(to: CGPoint(x: 0.25292*width, y: 0.40184*height))
                path.addCurve(to: CGPoint(x: 0.24597*width, y: 0.4286*height), control1: CGPoint(x: 0.25155*width, y: 0.40332*height), control2: CGPoint(x: 0.24444*width, y: 0.41188*height))
                path.addCurve(to: CGPoint(x: 0.24877*width, y: 0.44716*height), control1: CGPoint(x: 0.24655*width, y: 0.435*height), control2: CGPoint(x: 0.24764*width, y: 0.44091*height))
                path.addCurve(to: CGPoint(x: 0.25683*width, y: 0.48582*height), control1: CGPoint(x: 0.25081*width, y: 0.4583*height), control2: CGPoint(x: 0.25762*width, y: 0.47091*height))
                path.addCurve(to: CGPoint(x: 0.25745*width, y: 0.53441*height), control1: CGPoint(x: 0.25562*width, y: 0.50853*height), control2: CGPoint(x: 0.25611*width, y: 0.53022*height))
                path.addCurve(to: CGPoint(x: 0.26979*width, y: 0.55772*height), control1: CGPoint(x: 0.25868*width, y: 0.53826*height), control2: CGPoint(x: 0.26933*width, y: 0.55693*height))
                path.addLine(to: CGPoint(x: 0.27019*width, y: 0.55841*height))
                path.addLine(to: CGPoint(x: 0.27125*width, y: 0.55823*height))
                path.addCurve(to: CGPoint(x: 0.27824*width, y: 0.55139*height), control1: CGPoint(x: 0.27132*width, y: 0.55821*height), control2: CGPoint(x: 0.27769*width, y: 0.55701*height))
                path.addLine(to: CGPoint(x: 0.28164*width, y: 0.55398*height))
                path.addLine(to: CGPoint(x: 0.28255*width, y: 0.55315*height))
                path.addCurve(to: CGPoint(x: 0.2866*width, y: 0.54662*height), control1: CGPoint(x: 0.28275*width, y: 0.55296*height), control2: CGPoint(x: 0.28574*width, y: 0.55012*height))
                path.addCurve(to: CGPoint(x: 0.28785*width, y: 0.53435*height), control1: CGPoint(x: 0.2885*width, y: 0.54449*height), control2: CGPoint(x: 0.29243*width, y: 0.539*height))
                path.addCurve(to: CGPoint(x: 0.27398*width, y: 0.51802*height), control1: CGPoint(x: 0.28264*width, y: 0.52906*height), control2: CGPoint(x: 0.27407*width, y: 0.51813*height))
                path.addLine(to: CGPoint(x: 0.27398*width, y: 0.51802*height))
                path.addCurve(to: CGPoint(x: 0.27384*width, y: 0.51711*height), control1: CGPoint(x: 0.27396*width, y: 0.51765*height), control2: CGPoint(x: 0.27391*width, y: 0.51735*height))
                path.addCurve(to: CGPoint(x: 0.27748*width, y: 0.50735*height), control1: CGPoint(x: 0.27512*width, y: 0.51062*height), control2: CGPoint(x: 0.27384*width, y: 0.50826*height))
                path.addCurve(to: CGPoint(x: 0.2781*width, y: 0.50738*height), control1: CGPoint(x: 0.27778*width, y: 0.50727*height), control2: CGPoint(x: 0.27794*width, y: 0.5073*height))
                path.addCurve(to: CGPoint(x: 0.28199*width, y: 0.51472*height), control1: CGPoint(x: 0.28074*width, y: 0.5085*height), control2: CGPoint(x: 0.28134*width, y: 0.51153*height))
                path.addCurve(to: CGPoint(x: 0.28551*width, y: 0.52323*height), control1: CGPoint(x: 0.28259*width, y: 0.51772*height), control2: CGPoint(x: 0.28322*width, y: 0.52082*height))
                path.addCurve(to: CGPoint(x: 0.29715*width, y: 0.52704*height), control1: CGPoint(x: 0.28819*width, y: 0.52605*height), control2: CGPoint(x: 0.29234*width, y: 0.52971*height))
                path.addCurve(to: CGPoint(x: 0.29678*width, y: 0.50961*height), control1: CGPoint(x: 0.30032*width, y: 0.52528*height), control2: CGPoint(x: 0.29755*width, y: 0.51319*height))
                path.addCurve(to: CGPoint(x: 0.29317*width, y: 0.49681*height), control1: CGPoint(x: 0.29583*width, y: 0.50514*height), control2: CGPoint(x: 0.29583*width, y: 0.50389*height))
                path.addCurve(to: CGPoint(x: 0.29002*width, y: 0.48787*height), control1: CGPoint(x: 0.29148*width, y: 0.4923*height), control2: CGPoint(x: 0.29046*width, y: 0.48995*height))
                path.addCurve(to: CGPoint(x: 0.29144*width, y: 0.47375*height), control1: CGPoint(x: 0.28979*width, y: 0.48614*height), control2: CGPoint(x: 0.29046*width, y: 0.47898*height))
                path.addCurve(to: CGPoint(x: 0.30405*width, y: 0.44748*height), control1: CGPoint(x: 0.29255*width, y: 0.46773*height), control2: CGPoint(x: 0.29812*width, y: 0.4579*height))
                path.addCurve(to: CGPoint(x: 0.31822*width, y: 0.41614*height), control1: CGPoint(x: 0.31079*width, y: 0.43559*height), control2: CGPoint(x: 0.31778*width, y: 0.42329*height))
                path.addCurve(to: CGPoint(x: 0.31593*width, y: 0.39801*height), control1: CGPoint(x: 0.31891*width, y: 0.40508*height), control2: CGPoint(x: 0.31671*width, y: 0.39958*height))
                path.addCurve(to: CGPoint(x: 0.32229*width, y: 0.38897*height), control1: CGPoint(x: 0.31734*width, y: 0.39688*height), control2: CGPoint(x: 0.32123*width, y: 0.39343*height))
                path.addCurve(to: CGPoint(x: 0.3231*width, y: 0.37452*height), control1: CGPoint(x: 0.32352*width, y: 0.38377*height), control2: CGPoint(x: 0.32315*width, y: 0.37474*height))
                path.addCurve(to: CGPoint(x: 0.33398*width, y: 0.35164*height), control1: CGPoint(x: 0.32315*width, y: 0.37437*height), control2: CGPoint(x: 0.32722*width, y: 0.35878*height))
                path.addCurve(to: CGPoint(x: 0.34986*width, y: 0.33002*height), control1: CGPoint(x: 0.3391*width, y: 0.3462*height), control2: CGPoint(x: 0.34667*width, y: 0.33559*height))
                path.addCurve(to: CGPoint(x: 0.35366*width, y: 0.34307*height), control1: CGPoint(x: 0.35104*width, y: 0.33551*height), control2: CGPoint(x: 0.35234*width, y: 0.34043*height))
                path.addCurve(to: CGPoint(x: 0.35949*width, y: 0.35369*height), control1: CGPoint(x: 0.35532*width, y: 0.3464*height), control2: CGPoint(x: 0.35745*width, y: 0.35011*height))
                path.addCurve(to: CGPoint(x: 0.36588*width, y: 0.36614*height), control1: CGPoint(x: 0.36241*width, y: 0.3588*height), control2: CGPoint(x: 0.36519*width, y: 0.36363*height))
                path.addCurve(to: CGPoint(x: 0.36595*width, y: 0.40461*height), control1: CGPoint(x: 0.36687*width, y: 0.36971*height), control2: CGPoint(x: 0.36618*width, y: 0.39599*height))
                path.addCurve(to: CGPoint(x: 0.36586*width, y: 0.40799*height), control1: CGPoint(x: 0.3659*width, y: 0.40647*height), control2: CGPoint(x: 0.36586*width, y: 0.40769*height))
                path.addCurve(to: CGPoint(x: 0.36583*width, y: 0.40802*height), control1: CGPoint(x: 0.36586*width, y: 0.40801*height), control2: CGPoint(x: 0.36586*width, y: 0.40801*height))
                path.addCurve(to: CGPoint(x: 0.36532*width, y: 0.4088*height), control1: CGPoint(x: 0.3656*width, y: 0.40819*height), control2: CGPoint(x: 0.36542*width, y: 0.40849*height))
                path.addCurve(to: CGPoint(x: 0.36324*width, y: 0.41108*height), control1: CGPoint(x: 0.36481*width, y: 0.40943*height), control2: CGPoint(x: 0.36398*width, y: 0.41028*height))
                path.addCurve(to: CGPoint(x: 0.35366*width, y: 0.4296*height), control1: CGPoint(x: 0.35917*width, y: 0.41537*height), control2: CGPoint(x: 0.35234*width, y: 0.42253*height))
                path.addCurve(to: CGPoint(x: 0.35757*width, y: 0.44176*height), control1: CGPoint(x: 0.35512*width, y: 0.43748*height), control2: CGPoint(x: 0.35692*width, y: 0.44077*height))
                path.addCurve(to: CGPoint(x: 0.34787*width, y: 0.48173*height), control1: CGPoint(x: 0.35623*width, y: 0.4446*height), control2: CGPoint(x: 0.34634*width, y: 0.46617*height))
                path.addCurve(to: CGPoint(x: 0.34116*width, y: 0.50634*height), control1: CGPoint(x: 0.3484*width, y: 0.48716*height), control2: CGPoint(x: 0.34521*width, y: 0.49562*height))
                path.addCurve(to: CGPoint(x: 0.32387*width, y: 0.57182*height), control1: CGPoint(x: 0.33595*width, y: 0.52015*height), control2: CGPoint(x: 0.32606*width, y: 0.55198*height))
                path.addCurve(to: CGPoint(x: 0.33674*width, y: 0.65292*height), control1: CGPoint(x: 0.32062*width, y: 0.60117*height), control2: CGPoint(x: 0.33324*width, y: 0.63477*height))
                path.addCurve(to: CGPoint(x: 0.33806*width, y: 0.66015*height), control1: CGPoint(x: 0.33748*width, y: 0.65681*height), control2: CGPoint(x: 0.33799*width, y: 0.65937*height))
                path.addCurve(to: CGPoint(x: 0.33766*width, y: 0.66492*height), control1: CGPoint(x: 0.33822*width, y: 0.66207*height), control2: CGPoint(x: 0.33796*width, y: 0.6634*height))
                path.addCurve(to: CGPoint(x: 0.33725*width, y: 0.6738*height), control1: CGPoint(x: 0.33725*width, y: 0.66701*height), control2: CGPoint(x: 0.33678*width, y: 0.66937*height))
                path.addCurve(to: CGPoint(x: 0.33755*width, y: 0.67526*height), control1: CGPoint(x: 0.33729*width, y: 0.67424*height), control2: CGPoint(x: 0.33741*width, y: 0.67474*height))
                path.addCurve(to: CGPoint(x: 0.32046*width, y: 0.71574*height), control1: CGPoint(x: 0.33586*width, y: 0.67781*height), control2: CGPoint(x: 0.32086*width, y: 0.70077*height))
                path.addCurve(to: CGPoint(x: 0.3275*width, y: 0.7565*height), control1: CGPoint(x: 0.32028*width, y: 0.72306*height), control2: CGPoint(x: 0.3238*width, y: 0.73931*height))
                path.addCurve(to: CGPoint(x: 0.33509*width, y: 0.79809*height), control1: CGPoint(x: 0.33088*width, y: 0.77207*height), control2: CGPoint(x: 0.33407*width, y: 0.78815*height))
                path.addLine(to: CGPoint(x: 0.33512*width, y: 0.79835*height))
                path.addCurve(to: CGPoint(x: 0.33532*width, y: 0.80071*height), control1: CGPoint(x: 0.33521*width, y: 0.79918*height), control2: CGPoint(x: 0.33528*width, y: 0.79997*height))
                path.addCurve(to: CGPoint(x: 0.33421*width, y: 0.81767*height), control1: CGPoint(x: 0.33549*width, y: 0.80603*height), control2: CGPoint(x: 0.33472*width, y: 0.81664*height))
                path.addCurve(to: CGPoint(x: 0.33199*width, y: 0.826*height), control1: CGPoint(x: 0.33301*width, y: 0.82011*height), control2: CGPoint(x: 0.3319*width, y: 0.82242*height))
                path.addCurve(to: CGPoint(x: 0.33102*width, y: 0.8266*height), control1: CGPoint(x: 0.33167*width, y: 0.82622*height), control2: CGPoint(x: 0.33134*width, y: 0.82642*height))
                path.addCurve(to: CGPoint(x: 0.32308*width, y: 0.83579*height), control1: CGPoint(x: 0.3266*width, y: 0.82912*height), control2: CGPoint(x: 0.32481*width, y: 0.8325*height))
                path.addCurve(to: CGPoint(x: 0.32137*width, y: 0.83884*height), control1: CGPoint(x: 0.32252*width, y: 0.83687*height), control2: CGPoint(x: 0.32197*width, y: 0.83787*height))
                path.addCurve(to: CGPoint(x: 0.29498*width, y: 0.85537*height), control1: CGPoint(x: 0.31898*width, y: 0.84256*height), control2: CGPoint(x: 0.29787*width, y: 0.85417*height))
                path.addCurve(to: CGPoint(x: 0.28694*width, y: 0.86194*height), control1: CGPoint(x: 0.29271*width, y: 0.85631*height), control2: CGPoint(x: 0.28694*width, y: 0.86194*height))
                path.addCurve(to: CGPoint(x: 0.28588*width, y: 0.8677*height), control1: CGPoint(x: 0.28479*width, y: 0.86349*height), control2: CGPoint(x: 0.28546*width, y: 0.86602*height))
                path.addCurve(to: CGPoint(x: 0.28609*width, y: 0.86852*height), control1: CGPoint(x: 0.28595*width, y: 0.86799*height), control2: CGPoint(x: 0.28602*width, y: 0.86827*height))
                path.addCurve(to: CGPoint(x: 0.28701*width, y: 0.87052*height), control1: CGPoint(x: 0.28627*width, y: 0.86941*height), control2: CGPoint(x: 0.28667*width, y: 0.87003*height))
                path.addCurve(to: CGPoint(x: 0.28752*width, y: 0.87167*height), control1: CGPoint(x: 0.28729*width, y: 0.87096*height), control2: CGPoint(x: 0.2875*width, y: 0.87127*height))
                path.addCurve(to: CGPoint(x: 0.28729*width, y: 0.87341*height), control1: CGPoint(x: 0.28755*width, y: 0.87219*height), control2: CGPoint(x: 0.28741*width, y: 0.87281*height))
                path.addCurve(to: CGPoint(x: 0.28706*width, y: 0.87503*height), control1: CGPoint(x: 0.28718*width, y: 0.87395*height), control2: CGPoint(x: 0.28706*width, y: 0.87452*height))
                path.addCurve(to: CGPoint(x: 0.28847*width, y: 0.87897*height), control1: CGPoint(x: 0.28704*width, y: 0.87597*height), control2: CGPoint(x: 0.28711*width, y: 0.87823*height))
                path.addCurve(to: CGPoint(x: 0.29106*width, y: 0.87983*height), control1: CGPoint(x: 0.28926*width, y: 0.8794*height), control2: CGPoint(x: 0.29*width, y: 0.87969*height))
                path.addCurve(to: CGPoint(x: 0.2906*width, y: 0.88074*height), control1: CGPoint(x: 0.29095*width, y: 0.88006*height), control2: CGPoint(x: 0.29079*width, y: 0.88037*height))
                path.addCurve(to: CGPoint(x: 0.29301*width, y: 0.88478*height), control1: CGPoint(x: 0.28977*width, y: 0.88241*height), control2: CGPoint(x: 0.29162*width, y: 0.8841*height))
                path.addCurve(to: CGPoint(x: 0.29664*width, y: 0.88528*height), control1: CGPoint(x: 0.29398*width, y: 0.88526*height), control2: CGPoint(x: 0.29556*width, y: 0.88531*height))
                path.addCurve(to: CGPoint(x: 0.29671*width, y: 0.88559*height), control1: CGPoint(x: 0.29664*width, y: 0.88542*height), control2: CGPoint(x: 0.29669*width, y: 0.88551*height))
                path.addCurve(to: CGPoint(x: 0.29975*width, y: 0.8891*height), control1: CGPoint(x: 0.29687*width, y: 0.88676*height), control2: CGPoint(x: 0.29748*width, y: 0.88838*height))
                path.addCurve(to: CGPoint(x: 0.30456*width, y: 0.88923*height), control1: CGPoint(x: 0.30204*width, y: 0.88983*height), control2: CGPoint(x: 0.30322*width, y: 0.88965*height))
                path.addCurve(to: CGPoint(x: 0.31734*width, y: 0.89281*height), control1: CGPoint(x: 0.30718*width, y: 0.89165*height), control2: CGPoint(x: 0.31252*width, y: 0.89312*height))
                path.addCurve(to: CGPoint(x: 0.31917*width, y: 0.89259*height), control1: CGPoint(x: 0.31796*width, y: 0.89276*height), control2: CGPoint(x: 0.31856*width, y: 0.8927*height))
                path.addCurve(to: CGPoint(x: 0.33262*width, y: 0.88509*height), control1: CGPoint(x: 0.32412*width, y: 0.89174*height), control2: CGPoint(x: 0.33032*width, y: 0.8889*height))
                path.addCurve(to: CGPoint(x: 0.33954*width, y: 0.88034*height), control1: CGPoint(x: 0.33447*width, y: 0.88204*height), control2: CGPoint(x: 0.33715*width, y: 0.88103*height))
                path.addCurve(to: CGPoint(x: 0.35623*width, y: 0.86414*height), control1: CGPoint(x: 0.3494*width, y: 0.87827*height), control2: CGPoint(x: 0.35479*width, y: 0.87094*height))
                path.addCurve(to: CGPoint(x: 0.36477*width, y: 0.85025*height), control1: CGPoint(x: 0.3575*width, y: 0.85813*height), control2: CGPoint(x: 0.36326*width, y: 0.85159*height))
                path.addCurve(to: CGPoint(x: 0.37928*width, y: 0.84244*height), control1: CGPoint(x: 0.37167*width, y: 0.84832*height), control2: CGPoint(x: 0.37574*width, y: 0.84588*height))
                path.addCurve(to: CGPoint(x: 0.38211*width, y: 0.8335*height), control1: CGPoint(x: 0.38299*width, y: 0.83881*height), control2: CGPoint(x: 0.38313*width, y: 0.8365*height))
                path.addCurve(to: CGPoint(x: 0.3775*width, y: 0.81509*height), control1: CGPoint(x: 0.38111*width, y: 0.83065*height), control2: CGPoint(x: 0.37845*width, y: 0.81719*height))
                path.addCurve(to: CGPoint(x: 0.37567*width, y: 0.80912*height), control1: CGPoint(x: 0.37669*width, y: 0.81326*height), control2: CGPoint(x: 0.37632*width, y: 0.81139*height))
                path.addCurve(to: CGPoint(x: 0.39076*width, y: 0.75826*height), control1: CGPoint(x: 0.37368*width, y: 0.80202*height), control2: CGPoint(x: 0.38688*width, y: 0.7654*height))
                path.addCurve(to: CGPoint(x: 0.39685*width, y: 0.74907*height), control1: CGPoint(x: 0.39225*width, y: 0.75552*height), control2: CGPoint(x: 0.39438*width, y: 0.75255*height))
                path.addCurve(to: CGPoint(x: 0.41042*width, y: 0.7267*height), control1: CGPoint(x: 0.40104*width, y: 0.74321*height), control2: CGPoint(x: 0.40625*width, y: 0.73593*height))
                path.addCurve(to: CGPoint(x: 0.40556*width, y: 0.67819*height), control1: CGPoint(x: 0.41671*width, y: 0.71273*height), control2: CGPoint(x: 0.40676*width, y: 0.68185*height))
                path.addCurve(to: CGPoint(x: 0.4153*width, y: 0.66495*height), control1: CGPoint(x: 0.40921*width, y: 0.67392*height), control2: CGPoint(x: 0.41248*width, y: 0.66948*height))
                path.addCurve(to: CGPoint(x: 0.42074*width, y: 0.6537*height), control1: CGPoint(x: 0.41757*width, y: 0.66133*height), control2: CGPoint(x: 0.41968*width, y: 0.65758*height))
                path.addCurve(to: CGPoint(x: 0.42525*width, y: 0.62466*height), control1: CGPoint(x: 0.42231*width, y: 0.64799*height), control2: CGPoint(x: 0.42368*width, y: 0.63718*height))
                path.addCurve(to: CGPoint(x: 0.43016*width, y: 0.59106*height), control1: CGPoint(x: 0.42664*width, y: 0.6136*height), control2: CGPoint(x: 0.42824*width, y: 0.60106*height))
                path.addCurve(to: CGPoint(x: 0.44139*width, y: 0.55356*height), control1: CGPoint(x: 0.43255*width, y: 0.57872*height), control2: CGPoint(x: 0.43745*width, y: 0.56477*height))
                path.addCurve(to: CGPoint(x: 0.44718*width, y: 0.53528*height), control1: CGPoint(x: 0.44407*width, y: 0.5459*height), control2: CGPoint(x: 0.44641*width, y: 0.53927*height))
                path.addCurve(to: CGPoint(x: 0.44639*width, y: 0.51713*height), control1: CGPoint(x: 0.44861*width, y: 0.52781*height), control2: CGPoint(x: 0.4472*width, y: 0.52037*height))
                path.addCurve(to: CGPoint(x: 0.45044*width, y: 0.51713*height), control1: CGPoint(x: 0.44725*width, y: 0.51719*height), control2: CGPoint(x: 0.44981*width, y: 0.51721*height))
                path.addCurve(to: CGPoint(x: 0.44965*width, y: 0.53529*height), control1: CGPoint(x: 0.44965*width, y: 0.52037*height), control2: CGPoint(x: 0.44824*width, y: 0.52782*height))
                path.addCurve(to: CGPoint(x: 0.45544*width, y: 0.55358*height), control1: CGPoint(x: 0.45042*width, y: 0.53929*height), control2: CGPoint(x: 0.45275*width, y: 0.54591*height))
                path.addCurve(to: CGPoint(x: 0.46667*width, y: 0.59108*height), control1: CGPoint(x: 0.45938*width, y: 0.56478*height), control2: CGPoint(x: 0.46428*width, y: 0.57873*height))
                path.addCurve(to: CGPoint(x: 0.47157*width, y: 0.62468*height), control1: CGPoint(x: 0.46859*width, y: 0.6011*height), control2: CGPoint(x: 0.47019*width, y: 0.61363*height))
                path.addCurve(to: CGPoint(x: 0.47609*width, y: 0.65372*height), control1: CGPoint(x: 0.47315*width, y: 0.63719*height), control2: CGPoint(x: 0.47451*width, y: 0.64801*height))
                path.addCurve(to: CGPoint(x: 0.48153*width, y: 0.66497*height), control1: CGPoint(x: 0.47715*width, y: 0.65759*height), control2: CGPoint(x: 0.47928*width, y: 0.66134*height))
                path.addCurve(to: CGPoint(x: 0.49127*width, y: 0.67821*height), control1: CGPoint(x: 0.48435*width, y: 0.66949*height), control2: CGPoint(x: 0.48762*width, y: 0.67394*height))
                path.addCurve(to: CGPoint(x: 0.48641*width, y: 0.72671*height), control1: CGPoint(x: 0.49007*width, y: 0.68187*height), control2: CGPoint(x: 0.48009*width, y: 0.71275*height))
                path.addCurve(to: CGPoint(x: 0.49998*width, y: 0.74909*height), control1: CGPoint(x: 0.49058*width, y: 0.73594*height), control2: CGPoint(x: 0.49579*width, y: 0.74323*height))
                path.addCurve(to: CGPoint(x: 0.50606*width, y: 0.75827*height), control1: CGPoint(x: 0.50245*width, y: 0.75255*height), control2: CGPoint(x: 0.50458*width, y: 0.75554*height))
                path.addCurve(to: CGPoint(x: 0.52116*width, y: 0.80914*height), control1: CGPoint(x: 0.50995*width, y: 0.7654*height), control2: CGPoint(x: 0.52315*width, y: 0.80204*height))
                path.addCurve(to: CGPoint(x: 0.51933*width, y: 0.81511*height), control1: CGPoint(x: 0.52051*width, y: 0.81142*height), control2: CGPoint(x: 0.52014*width, y: 0.81329*height))
                path.addCurve(to: CGPoint(x: 0.51472*width, y: 0.83352*height), control1: CGPoint(x: 0.5184*width, y: 0.81719*height), control2: CGPoint(x: 0.51572*width, y: 0.83065*height))
                path.addCurve(to: CGPoint(x: 0.51755*width, y: 0.84245*height), control1: CGPoint(x: 0.51368*width, y: 0.83653*height), control2: CGPoint(x: 0.51384*width, y: 0.83883*height))
                path.addCurve(to: CGPoint(x: 0.53206*width, y: 0.85026*height), control1: CGPoint(x: 0.52109*width, y: 0.84591*height), control2: CGPoint(x: 0.52516*width, y: 0.84835*height))
                path.addCurve(to: CGPoint(x: 0.5406*width, y: 0.86415*height), control1: CGPoint(x: 0.53356*width, y: 0.8516*height), control2: CGPoint(x: 0.53935*width, y: 0.85815*height))
                path.addCurve(to: CGPoint(x: 0.55729*width, y: 0.88035*height), control1: CGPoint(x: 0.54204*width, y: 0.87096*height), control2: CGPoint(x: 0.54743*width, y: 0.87829*height))
                path.addCurve(to: CGPoint(x: 0.56421*width, y: 0.88511*height), control1: CGPoint(x: 0.55968*width, y: 0.88105*height), control2: CGPoint(x: 0.56238*width, y: 0.88205*height))
                path.addCurve(to: CGPoint(x: 0.57766*width, y: 0.89261*height), control1: CGPoint(x: 0.5665*width, y: 0.88892*height), control2: CGPoint(x: 0.57271*width, y: 0.89176*height))
                path.addCurve(to: CGPoint(x: 0.57949*width, y: 0.89282*height), control1: CGPoint(x: 0.57826*width, y: 0.89272*height), control2: CGPoint(x: 0.57887*width, y: 0.89278*height))
                path.addCurve(to: CGPoint(x: 0.59227*width, y: 0.88924*height), control1: CGPoint(x: 0.58428*width, y: 0.89313*height), control2: CGPoint(x: 0.58963*width, y: 0.89165*height))
                path.addCurve(to: CGPoint(x: 0.59708*width, y: 0.88912*height), control1: CGPoint(x: 0.59361*width, y: 0.88968*height), control2: CGPoint(x: 0.59477*width, y: 0.88985*height))
                path.addCurve(to: CGPoint(x: 0.60014*width, y: 0.88531*height), control1: CGPoint(x: 0.59954*width, y: 0.88835*height), control2: CGPoint(x: 0.60005*width, y: 0.88648*height))
                path.addCurve(to: CGPoint(x: 0.6038*width, y: 0.88481*height), control1: CGPoint(x: 0.60123*width, y: 0.88534*height), control2: CGPoint(x: 0.6028*width, y: 0.88531*height))
                path.addCurve(to: CGPoint(x: 0.6062*width, y: 0.88077*height), control1: CGPoint(x: 0.60519*width, y: 0.88414*height), control2: CGPoint(x: 0.60704*width, y: 0.88244*height))
                path.addCurve(to: CGPoint(x: 0.60579*width, y: 0.87992*height), control1: CGPoint(x: 0.60602*width, y: 0.88043*height), control2: CGPoint(x: 0.60588*width, y: 0.88014*height))
                path.addLine(to: CGPoint(x: 0.60579*width, y: 0.87992*height))
                path.addCurve(to: CGPoint(x: 0.60576*width, y: 0.87986*height), control1: CGPoint(x: 0.60579*width, y: 0.87991*height), control2: CGPoint(x: 0.60576*width, y: 0.87989*height))
                path.addCurve(to: CGPoint(x: 0.60836*width, y: 0.879*height), control1: CGPoint(x: 0.60683*width, y: 0.87972*height), control2: CGPoint(x: 0.60757*width, y: 0.87943*height))
                path.addCurve(to: CGPoint(x: 0.60977*width, y: 0.87506*height), control1: CGPoint(x: 0.60972*width, y: 0.87826*height), control2: CGPoint(x: 0.60979*width, y: 0.87599*height))
                path.addCurve(to: CGPoint(x: 0.60954*width, y: 0.87344*height), control1: CGPoint(x: 0.60975*width, y: 0.87455*height), control2: CGPoint(x: 0.60963*width, y: 0.87398*height))
                path.addCurve(to: CGPoint(x: 0.60931*width, y: 0.8717*height), control1: CGPoint(x: 0.60942*width, y: 0.87284*height), control2: CGPoint(x: 0.60928*width, y: 0.87222*height))
                path.addCurve(to: CGPoint(x: 0.60981*width, y: 0.87056*height), control1: CGPoint(x: 0.60931*width, y: 0.87131*height), control2: CGPoint(x: 0.60951*width, y: 0.87099*height))
                path.addCurve(to: CGPoint(x: 0.61074*width, y: 0.86855*height), control1: CGPoint(x: 0.61014*width, y: 0.87006*height), control2: CGPoint(x: 0.61056*width, y: 0.86944*height))
                path.addCurve(to: CGPoint(x: 0.61095*width, y: 0.86773*height), control1: CGPoint(x: 0.61079*width, y: 0.8683*height), control2: CGPoint(x: 0.61086*width, y: 0.86802*height))
                path.addCurve(to: CGPoint(x: 0.60988*width, y: 0.86198*height), control1: CGPoint(x: 0.61139*width, y: 0.86605*height), control2: CGPoint(x: 0.61204*width, y: 0.86352*height))
                path.addCurve(to: CGPoint(x: 0.60185*width, y: 0.8554*height), control1: CGPoint(x: 0.60988*width, y: 0.86198*height), control2: CGPoint(x: 0.60412*width, y: 0.85634*height))
                path.addCurve(to: CGPoint(x: 0.57546*width, y: 0.83887*height), control1: CGPoint(x: 0.59894*width, y: 0.85418*height), control2: CGPoint(x: 0.57782*width, y: 0.84258*height))
                path.addCurve(to: CGPoint(x: 0.57375*width, y: 0.83582*height), control1: CGPoint(x: 0.57484*width, y: 0.8379*height), control2: CGPoint(x: 0.57431*width, y: 0.8369*height))
                path.addCurve(to: CGPoint(x: 0.56581*width, y: 0.82664*height), control1: CGPoint(x: 0.57201*width, y: 0.83255*height), control2: CGPoint(x: 0.57023*width, y: 0.82915*height))
                path.addCurve(to: CGPoint(x: 0.56484*width, y: 0.82603*height), control1: CGPoint(x: 0.56549*width, y: 0.82645*height), control2: CGPoint(x: 0.56516*width, y: 0.82625*height))
                path.addCurve(to: CGPoint(x: 0.56262*width, y: 0.8177*height), control1: CGPoint(x: 0.56493*width, y: 0.82245*height), control2: CGPoint(x: 0.5638*width, y: 0.82014*height))
                path.addCurve(to: CGPoint(x: 0.5615*width, y: 0.80074*height), control1: CGPoint(x: 0.56211*width, y: 0.81667*height), control2: CGPoint(x: 0.56134*width, y: 0.80606*height))
                path.addCurve(to: CGPoint(x: 0.56171*width, y: 0.79838*height), control1: CGPoint(x: 0.56155*width, y: 0.8*height), control2: CGPoint(x: 0.56162*width, y: 0.79921*height))
                path.addCurve(to: CGPoint(x: 0.56178*width, y: 0.79812*height), control1: CGPoint(x: 0.56174*width, y: 0.79829*height), control2: CGPoint(x: 0.56176*width, y: 0.79819*height))
                path.addLine(to: CGPoint(x: 0.56174*width, y: 0.79812*height))
                path.addCurve(to: CGPoint(x: 0.56933*width, y: 0.75653*height), control1: CGPoint(x: 0.56275*width, y: 0.78818*height), control2: CGPoint(x: 0.56597*width, y: 0.7721*height))
                path.addCurve(to: CGPoint(x: 0.57637*width, y: 0.71577*height), control1: CGPoint(x: 0.57306*width, y: 0.73934*height), control2: CGPoint(x: 0.57657*width, y: 0.7231*height))
                path.addCurve(to: CGPoint(x: 0.55931*width, y: 0.67535*height), control1: CGPoint(x: 0.57597*width, y: 0.7009*height), control2: CGPoint(x: 0.56118*width, y: 0.67815*height))
                path.addCurve(to: CGPoint(x: 0.5597*width, y: 0.67361*height), control1: CGPoint(x: 0.55951*width, y: 0.67472*height), control2: CGPoint(x: 0.55965*width, y: 0.67414*height))
                path.addCurve(to: CGPoint(x: 0.55928*width, y: 0.66474*height), control1: CGPoint(x: 0.56019*width, y: 0.66918*height), control2: CGPoint(x: 0.5597*width, y: 0.66682*height))
                path.addCurve(to: CGPoint(x: 0.55889*width, y: 0.65997*height), control1: CGPoint(x: 0.55898*width, y: 0.66321*height), control2: CGPoint(x: 0.5587*width, y: 0.66188*height))
                path.addCurve(to: CGPoint(x: 0.56021*width, y: 0.65273*height), control1: CGPoint(x: 0.55896*width, y: 0.65918*height), control2: CGPoint(x: 0.55944*width, y: 0.65662*height))
                path.addCurve(to: CGPoint(x: 0.57308*width, y: 0.57164*height), control1: CGPoint(x: 0.5637*width, y: 0.63458*height), control2: CGPoint(x: 0.57632*width, y: 0.60099*height))
                path.addCurve(to: CGPoint(x: 0.55579*width, y: 0.50616*height), control1: CGPoint(x: 0.57088*width, y: 0.55179*height), control2: CGPoint(x: 0.56102*width, y: 0.51997*height))
                path.addCurve(to: CGPoint(x: 0.54907*width, y: 0.48154*height), control1: CGPoint(x: 0.55174*width, y: 0.49545*height), control2: CGPoint(x: 0.54854*width, y: 0.48698*height))
                path.addCurve(to: CGPoint(x: 0.53937*width, y: 0.44157*height), control1: CGPoint(x: 0.5506*width, y: 0.46599*height), control2: CGPoint(x: 0.54072*width, y: 0.44443*height))
                path.addCurve(to: CGPoint(x: 0.54329*width, y: 0.42941*height), control1: CGPoint(x: 0.54002*width, y: 0.44059*height), control2: CGPoint(x: 0.54183*width, y: 0.43728*height))
                path.addCurve(to: CGPoint(x: 0.5337*width, y: 0.4109*height), control1: CGPoint(x: 0.54461*width, y: 0.42235*height), control2: CGPoint(x: 0.53778*width, y: 0.41519*height))
                path.addCurve(to: CGPoint(x: 0.53109*width, y: 0.40781*height), control1: CGPoint(x: 0.5325*width, y: 0.40963*height), control2: CGPoint(x: 0.53116*width, y: 0.40821*height))
                path.addCurve(to: CGPoint(x: 0.531*width, y: 0.40443*height), control1: CGPoint(x: 0.53109*width, y: 0.4075*height), control2: CGPoint(x: 0.53106*width, y: 0.40628*height))
                path.addCurve(to: CGPoint(x: 0.53106*width, y: 0.36596*height), control1: CGPoint(x: 0.53076*width, y: 0.3958*height), control2: CGPoint(x: 0.53005*width, y: 0.36952*height))
                path.addCurve(to: CGPoint(x: 0.53745*width, y: 0.3535*height), control1: CGPoint(x: 0.53178*width, y: 0.36344*height), control2: CGPoint(x: 0.53454*width, y: 0.35861*height))
                path.addCurve(to: CGPoint(x: 0.54329*width, y: 0.34289*height), control1: CGPoint(x: 0.53951*width, y: 0.34992*height), control2: CGPoint(x: 0.54162*width, y: 0.34622*height))
                path.addCurve(to: CGPoint(x: 0.5469*width, y: 0.33032*height), control1: CGPoint(x: 0.54456*width, y: 0.34034*height), control2: CGPoint(x: 0.54576*width, y: 0.3356*height))
                path.addCurve(to: CGPoint(x: 0.5469*width, y: 0.33029*height), control1: CGPoint(x: 0.5469*width, y: 0.33031*height), control2: CGPoint(x: 0.5469*width, y: 0.33031*height))
                path.addCurve(to: CGPoint(x: 0.56227*width, y: 0.3513*height), control1: CGPoint(x: 0.55019*width, y: 0.33573*height), control2: CGPoint(x: 0.55752*width, y: 0.34569*height))
                path.addCurve(to: CGPoint(x: 0.57396*width, y: 0.38864*height), control1: CGPoint(x: 0.57062*width, y: 0.36117*height), control2: CGPoint(x: 0.5735*width, y: 0.37727*height))
                path.addCurve(to: CGPoint(x: 0.58032*width, y: 0.39769*height), control1: CGPoint(x: 0.57414*width, y: 0.39316*height), control2: CGPoint(x: 0.57891*width, y: 0.39657*height))
                path.addCurve(to: CGPoint(x: 0.57803*width, y: 0.41582*height), control1: CGPoint(x: 0.57954*width, y: 0.39927*height), control2: CGPoint(x: 0.57734*width, y: 0.40477*height))
                path.addCurve(to: CGPoint(x: 0.5922*width, y: 0.44716*height), control1: CGPoint(x: 0.57847*width, y: 0.42296*height), control2: CGPoint(x: 0.58546*width, y: 0.43526*height))
                path.addCurve(to: CGPoint(x: 0.60481*width, y: 0.47343*height), control1: CGPoint(x: 0.5981*width, y: 0.45758*height), control2: CGPoint(x: 0.60368*width, y: 0.46742*height))
                path.addCurve(to: CGPoint(x: 0.60648*width, y: 0.4827*height), control1: CGPoint(x: 0.60562*width, y: 0.47776*height), control2: CGPoint(x: 0.60644*width, y: 0.48057*height))
                path.addCurve(to: CGPoint(x: 0.6062*width, y: 0.48887*height), control1: CGPoint(x: 0.60653*width, y: 0.48475*height), control2: CGPoint(x: 0.6065*width, y: 0.48681*height))
                path.addCurve(to: CGPoint(x: 0.60329*width, y: 0.49687*height), control1: CGPoint(x: 0.60593*width, y: 0.49077*height), control2: CGPoint(x: 0.60472*width, y: 0.49302*height))
                path.addCurve(to: CGPoint(x: 0.59968*width, y: 0.50968*height), control1: CGPoint(x: 0.60063*width, y: 0.50395*height), control2: CGPoint(x: 0.60063*width, y: 0.50522*height))
                path.addCurve(to: CGPoint(x: 0.59931*width, y: 0.5271*height), control1: CGPoint(x: 0.59891*width, y: 0.51326*height), control2: CGPoint(x: 0.59613*width, y: 0.52534*height))
                path.addCurve(to: CGPoint(x: 0.61095*width, y: 0.52329*height), control1: CGPoint(x: 0.60412*width, y: 0.52977*height), control2: CGPoint(x: 0.60826*width, y: 0.52611*height))
                path.addCurve(to: CGPoint(x: 0.61447*width, y: 0.51478*height), control1: CGPoint(x: 0.61324*width, y: 0.52088*height), control2: CGPoint(x: 0.61387*width, y: 0.51778*height))
                path.addCurve(to: CGPoint(x: 0.61836*width, y: 0.50744*height), control1: CGPoint(x: 0.61512*width, y: 0.51159*height), control2: CGPoint(x: 0.61572*width, y: 0.50856*height))
                path.addCurve(to: CGPoint(x: 0.61898*width, y: 0.50741*height), control1: CGPoint(x: 0.61854*width, y: 0.50736*height), control2: CGPoint(x: 0.6187*width, y: 0.50733*height))
                path.addCurve(to: CGPoint(x: 0.62262*width, y: 0.51718*height), control1: CGPoint(x: 0.62262*width, y: 0.50832*height), control2: CGPoint(x: 0.62134*width, y: 0.51068*height))
                path.addCurve(to: CGPoint(x: 0.62248*width, y: 0.51809*height), control1: CGPoint(x: 0.62255*width, y: 0.51741*height), control2: CGPoint(x: 0.6225*width, y: 0.51772*height))
                path.addLine(to: CGPoint(x: 0.62248*width, y: 0.51809*height))
                path.addCurve(to: CGPoint(x: 0.60861*width, y: 0.53441*height), control1: CGPoint(x: 0.62238*width, y: 0.51819*height), control2: CGPoint(x: 0.61382*width, y: 0.52912*height))
                path.addCurve(to: CGPoint(x: 0.60986*width, y: 0.54668*height), control1: CGPoint(x: 0.60405*width, y: 0.53906*height), control2: CGPoint(x: 0.60796*width, y: 0.54454*height))
                path.addCurve(to: CGPoint(x: 0.61391*width, y: 0.55321*height), control1: CGPoint(x: 0.61069*width, y: 0.5502*height), control2: CGPoint(x: 0.6137*width, y: 0.55302*height))
                path.addLine(to: CGPoint(x: 0.61481*width, y: 0.55404*height))
                path.addLine(to: CGPoint(x: 0.61822*width, y: 0.55145*height))
                path.addCurve(to: CGPoint(x: 0.62521*width, y: 0.55829*height), control1: CGPoint(x: 0.61877*width, y: 0.55707*height), control2: CGPoint(x: 0.62514*width, y: 0.55827*height))
                path.addLine(to: CGPoint(x: 0.62627*width, y: 0.55847*height))
                path.addLine(to: CGPoint(x: 0.62667*width, y: 0.55778*height))
                path.addCurve(to: CGPoint(x: 0.639*width, y: 0.53448*height), control1: CGPoint(x: 0.62713*width, y: 0.55699*height), control2: CGPoint(x: 0.63775*width, y: 0.5383*height))
                path.addCurve(to: CGPoint(x: 0.63963*width, y: 0.48588*height), control1: CGPoint(x: 0.64035*width, y: 0.53029*height), control2: CGPoint(x: 0.64083*width, y: 0.50861*height))
                path.addCurve(to: CGPoint(x: 0.64769*width, y: 0.44722*height), control1: CGPoint(x: 0.63884*width, y: 0.47097*height), control2: CGPoint(x: 0.64565*width, y: 0.45835*height))
                path.addCurve(to: CGPoint(x: 0.65049*width, y: 0.42866*height), control1: CGPoint(x: 0.64882*width, y: 0.44097*height), control2: CGPoint(x: 0.64991*width, y: 0.43506*height))
                path.addCurve(to: CGPoint(x: 0.6435*width, y: 0.40187*height), control1: CGPoint(x: 0.65197*width, y: 0.41191*height), control2: CGPoint(x: 0.64486*width, y: 0.40335*height))
                path.closeSubpath()
                return path.offsetBy(dx: 0.0515*width, dy: -0.002*height)
            }
        }
    }
}
