//
//  MuscleView.swift
//  goliath
//
//  Created by Christophe Beaulieu on 2025-08-19.
//

//import SwiftUI
//
//struct MuscleGroupView {
//}
//
//extension MuscleGroupView {
//    struct Detail: View {
//        var muscleGroup: MuscleGroup.Supported
//        
//        // TODO: In the descriptions, add references to the activities/muscles.
//        var body: some View {
//            switch muscleGroup {
//            case .abdominals: Abdominals()
//            case .abductors: Abductors()
//            case .adductors: Adductors()
//            case .biceps: Biceps()
//            case .calves: Calves()
//            case .forearms: Forearms()
//            case .glutes: Glutes()
//            case .hamstrings: Hamstrings()
//            case .laterals: Laterals()
//            case .lumbars: Lumbars()
//            case .neck: Neck()
//            case .obliques: Obliques()
//            case .pectorals: Pectorals()
//            case .quadriceps: Quadriceps()
//            case .deltoids: Deltoids()
//            case .trapezii: Trapezii()
//            case .triceps: Triceps()
//            }
//        }
//    }
//}
//
//extension MuscleGroupView {
//    struct Navigator: View {
//        @State private var presenting: MuscleGroup.Supported? = nil
//
//        var body: some View {
//            MusculoDiagramsView.AllCoronals(
//                presenting: MuscleGroup.Supported.allCases.compactMap { muscleGroup in
//                    try? MusculoDiagramsView.MuscleGroup(fromMuscleWith: muscleGroup.rawValue) {
//                        presenting = muscleGroup
//                    }
//                }
//            )
//            .navigationDestination(item: $presenting) { muscleGroup in
//                MuscleGroupView.Detail(muscleGroup: muscleGroup)
//            }
//        }
//    }
//}
//
//// MARK: MuscleGroupView.Detail
//extension MuscleGroupView.Detail {
//    struct Abdominals: View {
//        var body: some View {
//            List {
//                Group {
////                    Section {
////                        Bubble {
////                            Text("The abdominals, often referred to simply as the \"abs\", are a group of muscles located on the front and sides of the lower torso. They play a critical role in core stability, posture, and movement of the trunk.")
////                        }
////                    }
////                    .listRowSeparator(.hidden, edges: .top)
////
//                    Section("Primary muscles in group") {
//                        ForEach(Array([
//                            (name: "Rectus Abdominis", description: "A long, flat muscle that extends vertically along the length of the abdomen, commonly known as the \"six-pack\" due to its segmented appearance."),
//                            (name: "External Obliques", description: "Located on either side of the rectus abdominis, they help in rotating and laterally flexing the trunk."),
//                            (name: "Internal Obliques", description: "Located beneath the external obliques, they assist in similar functions but also provide added stability."),
//                            (name: "Transverse Abdominis", description: "The deepest abdominal muscle, it wraps around the spine for protection and stability."),
//                        ].enumerated()), id: \.offset) { index, muscle in
//                            HStack(alignment: .top) {
//                                Image(systemName: "\(index + 1).circle")
//                                    .foregroundColor(.secondary)
//                                Text(muscle.name).bold()
//                                + Text(": \(muscle.description)")
//                            }
//                        }
//                    }
//
//                    Section("Antagonist muscle group") {
//                        Text("The primary antagonist to the abdominals is the ")
//                        + Text("Erector Spinae").bold()
//                        + Text(". This group of muscles runs vertically along the spine and is responsible for extending the vertebral column and maintaining an upright posture.")
//                    }
//
//                    Section("Common exercises that target the abdominals") {
//                        ForEach(Array([
//                            (name: "Crunches", description: "Lie flat on your back, knees bent, and curl your chest towards your knees using your abs."),
//                            (name: "Leg Raises", description: "Lying on your back, keep your legs straight and raise them off the ground, then lower without touching the floor."),
//                            (name: "Bicycle Crunches", description: "Lie on your back and mimic a pedaling action with your legs while alternately touching each elbow to the opposite knee."),
//                            (name: "Plank", description: "In a push-up position but resting on your forearms, keep a straight line from head to heels. This primarily targets the transverse abdominis."),
//                            (name: "Russian Twists", description: "Sit on the floor, lean back slightly, lift your feet off the ground, and hold a weight or ball. Rotate your torso to touch the weight to the ground on each side."),
//                            (name: "Side Planks", description: "Lying on your side, prop yourself up on one forearm with legs stacked, lifting your hips so your body forms a straight line."),
//                            (name: "Hanging Leg Raises", description: "Using a pull-up bar, hang and lift your knees or straight legs up towards your chest."),
//                            (name: "Mountain Climbers", description: "Starting in a push-up position, bring one knee towards the chest and then switch legs in a running motion."),
//                        ].enumerated()), id: \.offset) { index, muscle in
//                            HStack(alignment: .top) {
//                                Image(systemName: "\(index + 1).circle")
//                                    .foregroundColor(.secondary)
//                                Text(muscle.name).bold()
//                                + Text(": \(muscle.description)")
//                            }
//                        }
//                    }
//
////                    Section {
////                        Bubble {
////                            Text("These exercises, when performed with proper technique, can strengthen and tone the abdominal muscles, providing better core stability and a more defined appearance.")
////                        }
////                    }
////                    .listRowSeparator(.hidden, edges: .top)
//                
//                    Section("Looking for different muscle?") {
//                        MuscleGroupView.Navigator()
//                    }
//                }
//                .listRowSeparator(.hidden, edges: .bottom)
//            }
//            .listStyle(.plain)
//            .navigationTitle("Abdominals")
//            .navigationBarTitleDisplayMode(.inline)
//        }
//    }
//}
//
//extension MuscleGroupView.Detail {
//    struct Abductors: View {
//        var body: some View {
//            List {
//                Group {
////                    Section {
////                        Bubble {
////                            Text("The abductors are a group of muscles located in the hip region that are responsible for moving the leg away from the midline of the body, or abduction. This motion is the opposite of bringing the legs together.")
////                        }
////                    }
////                    .listRowSeparator(.hidden, edges: .top)
//
//                    Section("Primary muscles in group") {
//                        ForEach(Array([
//                            (name: "Gluteus Medius", description: "Located on the outer surface of the pelvis, it's primarily responsible for hip abduction."),
//                            (name: "Gluteus Minimus", description: "Positioned beneath the gluteus medius, it aids in hip abduction."),
//                            (name: "Tensor Fasciae Latae", description: "A small muscle on the lateral aspect of the hip, it assists in hip abduction and stabilizes the hip joint."),
//                        ].enumerated()), id: \.offset) { index, muscle in
//                            HStack(alignment: .top) {
//                                Image(systemName: "\(index + 1).circle")
//                                    .foregroundColor(.secondary)
//                                Text(muscle.name).bold()
//                                + Text(": \(muscle.description)")
//                            }
//                        }
//                    }
//
//                    Section("Antagonist muscle group") {
//                        Text("The primary antagonist muscles to the abductors are the ")
//                        + Text("Adductors").bold()
//                        + Text(". These muscles are responsible for adduction, or drawing the leg towards the midline of the body. The main muscles in this group include the adductor longus, adductor brevis, adductor magnus, gracilis, and pectineus.")
//                    }
//
//                    Section("Common exercises that target the abductors") {
//                        ForEach(Array([
//                            (name: "Lateral Leg Raises", description: "Lying on one side with your legs straight, lift the top leg upwards and then lower it down."),
//                            (name: "Standing Leg Abductions", description: "Standing upright, lift one leg out to the side and then bring it back down."),
//                            (name: "Seated Leg Abductions", description: "Using a machine at the gym where you sit and push your legs outward against resistance."),
//                            (name: "Side Lunges", description: "Starting with feet together, step to one side and bend that knee while keeping the other leg straight."),
//                            (name: "Fire Hydrants", description: "Start on all fours (hands and knees) and lift one leg out to the side, mimicking a dog at a fire hydrant."),
//                            (name: "Cable Hip Abductions", description: "Attach an ankle strap to a low pulley, and with the cable attached to the ankle, move the leg out to the side."),
//                            (name: "Pilates Side Leg Series", description: "Various exercises done lying on your side to strengthen the abductors."),
//                            (name: "Clamshells", description: "Lying on one side with knees bent, keep feet together and lift the top knee."),
//                        ].enumerated()), id: \.offset) { index, muscle in
//                            HStack(alignment: .top) {
//                                Image(systemName: "\(index + 1).circle")
//                                    .foregroundColor(.secondary)
//                                Text(muscle.name).bold()
//                                + Text(": \(muscle.description)")
//                            }
//                        }
//                    }
//
////                    Section {
////                        Bubble {
////                            Text("Training the abductors can improve hip stability, support proper gait mechanics, and reduce the risk of injuries, especially those related to running and other athletic activities.")
////                        }
////                    }
////                    .listRowSeparator(.hidden, edges: .top)
//                
//                    Section("Looking for different muscle?") {
//                        MuscleGroupView.Navigator()
//                    }
//                }
//                .listRowSeparator(.hidden, edges: .bottom)
//            }
//            .listStyle(.plain)
//            .navigationTitle("Abductors")
//            .navigationBarTitleDisplayMode(.inline)
//        }
//    }
//}
//
//extension MuscleGroupView.Detail {
//    struct Adductors: View {
//        var body: some View {
//            List {
//                Group {
////                    Section {
////                        Bubble {
////                            Text("The adductors are a group of muscles in the inner thigh region that are responsible for pulling the leg inwards, toward the midline of the body, a movement known as adduction. These muscles play a vital role in stabilizing the pelvis during walking and running.")
////                        }
////                    }
////                    .listRowSeparator(.hidden, edges: .top)
//
//                    Section("Primary muscles in group") {
//                        ForEach(Array([
//                            "Adductor Longus",
//                            "Adductor Brevis",
//                            "Adductor Magnus",
//                            "Gracilis",
//                            "Pectineus",
//                        ].enumerated()), id: \.offset) { index, muscle in
//                            HStack(alignment: .top) {
//                                Image(systemName: "\(index + 1).circle")
//                                    .foregroundColor(.secondary)
//                                Text(muscle).bold()
//                            }
//                        }
//                    }
//                    
//                    Section("Antagonist muscle group") {
//                        Text("The primary antagonists to the adductors are the ")
//                        + Text("Abductors").bold()
//                        + Text(". These muscles, which include the gluteus medius, gluteus minimus, and tensor fasciae latae, are responsible for moving the leg away from the midline of the body, known as abduction.")
//                    }
//
//                    Section("Common exercises that target the adductors") {
//                        ForEach(Array([
//                            (name: "Seated Adduction Machine", description: "Using a machine at the gym where you sit and squeeze your legs together against resistance."),
//                            (name: "Standing Cable Hip Adduction", description: "Attach an ankle strap to a low pulley, and with the cable attached to the ankle, move the leg across the front of the body."),
//                            (name: "Adductor Squeeze", description: "Sitting or lying down, place a ball or pillow between your knees and squeeze."),
//                            (name: "Side-lying Adductor Leg Lifts", description: "Lie on one side and lift the bottom leg off the ground."),
//                            (name: "Lunges", description: "Specifically, taking a wide step forward or to the side, which can stretch and engage the adductors."),
//                            (name: "Sumo Squats or Plie Squats", description: "Wide-stance squats that emphasize the inner thighs."),
//                            (name: "Inner Thigh Leg Swings", description: "Holding onto a support, swing one leg in front of the other."),
//                            (name: "Pilates Adductor Exercises", description: "Various exercises focused on inner thigh engagement."),
//                        ].enumerated()), id: \.offset) { index, muscle in
//                            HStack(alignment: .top) {
//                                Image(systemName: "\(index + 1).circle")
//                                    .foregroundColor(.secondary)
//                                Text(muscle.name).bold()
//                                + Text(": \(muscle.description)")
//                            }
//                        }
//                    }
//
////                    Section {
////                        Bubble {
////                            Text("Engaging and strengthening the adductors can help in enhancing athletic performance, improving overall leg strength, and reducing the risk of groin strains and other related injuries.")
////                        }
////                    }
////                    .listRowSeparator(.hidden, edges: .top)
//                
//                    Section("Looking for different muscle?") {
//                        MuscleGroupView.Navigator()
//                    }
//                }
//                .listRowSeparator(.hidden, edges: .bottom)
//            }
//            .listStyle(.plain)
//            .navigationTitle("Adductors")
//            .navigationBarTitleDisplayMode(.inline)
//        }
//    }
//}
//
//extension MuscleGroupView.Detail {
//    struct Biceps: View {
//        var body: some View {
//            List {
//                Group {
////                    Section {
////                        Bubble {
////                            Text("The biceps, formally known as the biceps brachii, is a two-headed muscle located on the front of the upper arm. It spans from the shoulder to the elbow and plays a key role in lifting and bending the arm. Its primary function is the flexion of the elbow and supination of the forearm (turning the palm upward).")
////                        }
////                    }
////                    .listRowSeparator(.hidden, edges: .top)
//                    
//                    Section("Antagonist muscle group") {
//                        Text("The primary antagonist to the biceps is the ")
//                        + Text("Triceps Brachii").bold()
//                        + Text(". Located on the back of the upper arm, the triceps are responsible for extending the elbow, which is the opposite motion of the biceps.")
//                    }
//
//                    Section("Common exercises that target the biceps") {
//                        ForEach(Array([
//                            (name: "Dumbbell Curls", description: "Holding a dumbbell in each hand, with arms extended down, curl the weights while keeping the elbows close to the torso."),
//                            (name: "Hammer Curls", description: "Using dumbbells, the same motion as the regular curl but with the thumbs facing forward, emphasizing the brachialis and brachioradialis."),
//                            (name: "Concentration Curls", description: "Seated with a single dumbbell, resting that arm's elbow on the same leg, curl the weight up."),
//                            (name: "Preacher Curls", description: "Using a preacher bench, rest the backs of your arms on the pad and curl either a barbell or dumbbell upwards."),
//                            (name: "Cable Curls", description: "Using a cable machine with a bar or rope attachment, pull the weight towards you by flexing your elbows."),
//                            (name: "EZ Bar Curls", description: "Similar to barbell curls but using an EZ curl bar, which can be easier on the wrists."),
//                            (name: "Incline Dumbbell Curls", description: "Lying back on an incline bench, curl dumbbells from a hanging arm position. This provides a longer range of motion and stretches the biceps."),
//                            (name: "Resistance Band Curls", description: "Standing on a resistance band and holding its ends, curl upwards. This provides variable resistance throughout the curl."),
//                        ].enumerated()), id: \.offset) { index, muscle in
//                            HStack(alignment: .top) {
//                                Image(systemName: "\(index + 1).circle")
//                                    .foregroundColor(.secondary)
//                                Text(muscle.name).bold()
//                                + Text(": \(muscle.description)")
//                            }
//                        }
//                    }
//
////                    Section {
////                        Bubble {
////                            Text("Regularly training the biceps can improve the shape, size, and strength of the upper arm. Proper technique is essential for avoiding injuries and ensuring effective muscle engagement.")
////                        }
////                    }
////                    .listRowSeparator(.hidden, edges: .top)
//                
//                    Section("Looking for different muscle?") {
//                        MuscleGroupView.Navigator()
//                    }
//                }
//                .listRowSeparator(.hidden, edges: .bottom)
//            }
//            .listStyle(.plain)
//            .navigationTitle("Biceps Brachii")
//            .navigationBarTitleDisplayMode(.inline)
//        }
//    }
//}
//
//extension MuscleGroupView.Detail {
//    struct Calves: View {
//        var body: some View {
//            List {
//                Group {
////                    Section {
////                        Bubble {
////                            Text("The calves are the group of muscles located at the back of the lower leg. They play a fundamental role in movements like walking, running, and jumping.")
////                        }
////                    }
////                    .listRowSeparator(.hidden, edges: .top)
//                    
//                    Section("Primary muscles in group") {
//                        Section {
//                            ForEach(Array([
//                                (name: "Gastrocnemius", description: "This is the more superficial and larger muscle that has two heads (medial and lateral) and gives the calf its distinctive rounded shape."),
//                                (name: "Soleus", description: "Located beneath the gastrocnemius, it's flatter and contributes to the thickness and depth of the calf."),
//                            ].enumerated()), id: \.offset) { index, muscle in
//                                HStack(alignment: .top) {
//                                    Image(systemName: "\(index + 1).circle")
//                                        .foregroundColor(.secondary)
//                                    Text(muscle.name).bold()
//                                    + Text(": \(muscle.description)")
//                                }
//                            }
//                        }
//                        
//                        Text("Both muscles merge into the Achilles tendon, which inserts onto the heel bone (calcaneus).")
//                    }
//                    
//                    Section("Antagonist muscle group") {
//                        Text("The primary antagonists to the calves are the muscles located at the front of the shin, mainly the ")
//                        + Text("Tibialis Anterior").bold()
//                        + Text(". This muscle dorsiflexes the foot (pulls the foot upward) which is the opposite action of the calf muscles' primary function, plantarflexion (pointing the foot downwards).")
//                    }
//                    
//                    Section("Common exercises that target the calves") {
//                        ForEach(Array([
//                            (name: "Standing Calf Raises", description: "Using body weight or holding weights, push through the balls of your feet to rise onto your toes."),
//                            (name: "Seated Calf Raises", description: "Using a machine, sit and place weights on your thighs, then push through the balls of your feet."),
//                            (name: "Calf Press on Leg Press Machine", description: "Using a leg press machine, place your feet low on the platform and push using only your ankles."),
//                            (name: "Jump Rope", description: "Jumping rope engages the calves with each jump."),
//                            (name: "Box Jumps", description: "Jumping onto a platform or box requires a powerful calf contraction."),
//                            (name: "Stair Climbs", description: "Simply climbing stairs can engage the calf muscles."),
//                            (name: "Farmer's Walk on Toes", description: "Holding heavy weights in each hand, walk while staying elevated on your toes."),
//                            (name: "Resistance Band Calf Raises", description: "Standing on a resistance band and holding its ends, push through the balls of your feet to rise onto your toes."),
//                        ].enumerated()), id: \.offset) { index, muscle in
//                            HStack(alignment: .top) {
//                                Image(systemName: "\(index + 1).circle")
//                                    .foregroundColor(.secondary)
//                                Text(muscle.name).bold()
//                                + Text(": \(muscle.description)")
//                            }
//                        }
//                    }
//                    
////                    Section {
////                        Bubble {
////                            Text("Well-developed calves not only enhance the aesthetic appeal of the legs but also contribute to athletic performance and provide support and stability for everyday activities. Proper stretching and training can prevent strains and injuries in this muscle group.")
////                        }
////                    }
////                    .listRowSeparator(.hidden, edges: .top)
//                    
//                    Section("Looking for different muscle?") {
//                        MuscleGroupView.Navigator()
//                    }
//                }
//                .listRowSeparator(.hidden, edges: .bottom)
//            }
//            .listStyle(.plain)
//            .navigationTitle("Calves")
//            .navigationBarTitleDisplayMode(.inline)
//        }
//    }
//}
//
//extension MuscleGroupView.Detail {
//    struct Deltoids: View {
//        var body: some View {
//            List {
//                Group {
////                    Section {
////                        Bubble {
////                            Text("The deltoids, often simply called the \"delts\", are the rounded, triangular-shaped muscles covering the shoulder joint. They are primarily responsible for arm rotations and raising the arm away from the body.")
////                        }
////                    }
////                    .listRowSeparator(.hidden, edges: .top)
//                    
//                    Section("Primary muscles in group") {
//                        Text("The deltoid is divided into three distinct parts or \"heads\":")
//                        
//                        Section {
//                            ForEach(Array([
//                                (name: "Anterior (Front) Deltoid", description: "Involved in shoulder flexion and internal rotation."),
//                                (name: "Lateral (Middle) Deltoid", description: "Plays a major role in shoulder abduction (raising the arm out to the side)."),
//                                (name: "Posterior (Rear) Deltoid", description: "Responsible for shoulder extension and external rotation."),
//                            ].enumerated()), id: \.offset) { index, muscle in
//                                HStack(alignment: .top) {
//                                    Image(systemName: "\(index + 1).circle")
//                                        .foregroundColor(.secondary)
//                                    Text(muscle.name).bold()
//                                    + Text(": \(muscle.description)")
//                                }
//                            }
//                        }
//                    }
//                    
//                    Section("Antagonist muscle group") {
//                        Text("The primary antagonists to the deltoids are the ")
//                        + Text("Latissimus Dorsi").bold()
//                        + Text(" and some muscles of the rotator cuff, depending on the specific motion of the deltoid being countered.")
//                    }
//                    
//                    Section("Common exercises that target the deltoids") {
//                        ForEach(Array([
//                            (name: "Shoulder Press (Military Press)", description: "Using dumbbells or a barbell, press the weight from shoulder height to overhead."),
//                            (name: "Lateral Raises", description: "Holding a dumbbell in each hand, with arms at your sides, raise the arms out to the side until they are parallel with the ground."),
//                            (name: "Front Raises", description: "Holding a dumbbell in each hand, raise the arms in front of you until they're at shoulder height."),
//                            (name: "Rear Delt Flyes (Reverse Flyes)", description: "Holding a dumbbell in each hand and bending forward slightly, move the arms out to the sides in a reverse fly motion."),
//                            (name: "Face Pulls", description: "Using a rope attachment on a cable machine, pull the rope towards your face, focusing on pulling the hands apart and engaging the rear deltoids."),
//                            (name: "Dumbbell Shoulder Press", description: "Seated or standing, press dumbbells from shoulder height to overhead."),
//                            (name: "Arnold Press", description: "A variation of the dumbbell shoulder press, starting with palms facing the body and rotating them outward as you press up."),
//                            (name: "Upright Rows", description: "Holding a barbell or dumbbells, pull the weight upwards, leading with the elbows."),
//                            (name: "Bent Over Lateral Raises", description: "Bend over at the hips and, with a dumbbell in each hand, raise arms out to the sides, focusing on the rear deltoids."),
//                        ].enumerated()), id: \.offset) { index, muscle in
//                            HStack(alignment: .top) {
//                                Image(systemName: "\(index + 1).circle")
//                                    .foregroundColor(.secondary)
//                                Text(muscle.name).bold()
//                                + Text(": \(muscle.description)")
//                            }
//                        }
//                    }
//                    
////                    Section {
////                        Bubble {
////                            Text("Developing the deltoids not only provides an aesthetic broad-shouldered look but also ensures balanced shoulder strength, which can prevent injuries and promote overall shoulder health. Proper form and avoiding excessive weight are crucial to prevent shoulder injuries when training this muscle group.")
////                        }
////                    }
////                    .listRowSeparator(.hidden, edges: .top)
//                    
//                    Section("Looking for different muscle?") {
//                        MuscleGroupView.Navigator()
//                    }
//                }
//                .listRowSeparator(.hidden, edges: .bottom)
//            }
//            .listStyle(.plain)
//            .navigationTitle("Deltoids")
//            .navigationBarTitleDisplayMode(.inline)
//        }
//    }
//}
//
//extension MuscleGroupView.Detail {
//    struct Forearms: View {
//        var body: some View {
//            List {
//                Group {
////                    Section {
////                        Bubble {
////                            Text("The forearms comprise the area between the wrist and the elbow on the lower arm. They consist of multiple smaller muscles that allow for a wide range of motions, including wrist flexion, wrist extension, pronation, and supination.")
////                        }
////                    }
////                    .listRowSeparator(.hidden, edges: .top)
//                    
//                    Section("Primary muscles in group") {
//                        ForEach(Array([
//                            "Flexor Carpi Radialis",
//                            "Flexor Carpi Ulnaris",
//                            "Flexor Digitorum Superficialis",
//                            "Flexor Digitorum Profundus",
//                            "Extensor Carpi Radialis Longus",
//                            "Extensor Carpi Radialis Brevis",
//                            "Extensor Carpi Ulnaris",
//                            "Extensor Digitorum",
//                        ].enumerated()), id: \.offset) { index, muscle in
//                            HStack(alignment: .top) {
//                                Image(systemName: "\(index + 1).circle")
//                                    .foregroundColor(.secondary)
//                                Text(muscle).bold()
//                            }
//                        }
//                    }
//                    
//                    Section("Antagonist muscle group") {
//                        Text("Forearms have built-in antagonists. When considering wrist actions:")
//
//                        Section {
//                            ForEach(Array([
//                                (systemImage: "f.square", description: "The flexors of the wrist are antagonized by the extensors."),
//                                (systemImage: "e.square", description: "The extensors of the wrist are antagonized by the flexors."),
//                            ].enumerated()), id: \.offset) { index, row in
//                                HStack(alignment: .top) {
//                                    Image(systemName: row.systemImage)
//                                        .foregroundColor(.secondary)
//                                    Text(row.description)
//                                }
//                            }
//                        }
//                        
//                        Text("For pronation and supination:")
//
//                        Section {
//                            ForEach(Array([
//                                (systemImage: "p.square", description: "Pronator muscles (like the pronator teres) are antagonized by supinator muscles."),
//                                (systemImage: "s.square", description: "The primary supinator is antagonized by the pronators."),
//                            ].enumerated()), id: \.offset) { index, row in
//                                HStack(alignment: .top) {
//                                    Image(systemName: row.systemImage)
//                                        .foregroundColor(.secondary)
//                                    Text(row.description)
//                                }
//                            }
//                        }
//                    }
//                    
//                    Section("Common exercises that target the forearms") {
//                        ForEach(Array([
//                            (name: "Wrist Curls (Flexion)", description: "With forearm resting on a table or bench and holding a dumbbell, curl the wrist upward."),
//                            (name: "Reverse Wrist Curls (Extension)", description: "Similar position as wrist curls but with the palm facing down, lifting the back of the hand towards the ceiling."),
//                            (name: "Hammer Curls", description: "Curl dumbbells with palms facing inwards (towards each other) throughout the motion."),
//                            (name: "Farmer's Walk", description: "Holding heavy weights in each hand, simply walk for a distance or time. This engages the forearms due to the grip strength required."),
//                            (name: "Static Holds", description: "Hold a barbell or dumbbells for an extended period to challenge grip and forearm strength."),
//                            (name: "Plate Pinches", description: "Hold weight plates (like 2 x 10 lbs plates) together using only fingers, and pinch them for time."),
//                            (name: "Reverse Bicep Curls", description: "Using a barbell or dumbbells, perform a bicep curl but with palms facing down."),
//                            (name: "Wrist Rollers", description: "A device with a weight attached by a rope, which you roll up and down using wrist motions."),
//                            (name: "Rope Climbs or Towel Pull-Ups", description: "Engage the forearms significantly due to the grip challenge."),
//                        ].enumerated()), id: \.offset) { index, muscle in
//                            HStack(alignment: .top) {
//                                Image(systemName: "\(index + 1).circle")
//                                    .foregroundColor(.secondary)
//                                Text(muscle.name).bold()
//                                + Text(": \(muscle.description)")
//                            }
//                        }
//                    }
//                    
////                    Section {
////                        Bubble {
////                            Text("Training the forearms can enhance grip strength, which is crucial for many sports and daily activities. Strong forearms can also prevent strains and other injuries related to lifting and gripping.")
////                        }
////                    }
////                    .listRowSeparator(.hidden, edges: .top)
//                    
//                    Section("Looking for different muscle?") {
//                        MuscleGroupView.Navigator()
//                    }
//                }
//                .listRowSeparator(.hidden, edges: .bottom)
//            }
//            .listStyle(.plain)
//            .navigationTitle("Forearms")
//            .navigationBarTitleDisplayMode(.inline)
//        }
//    }
//}
//
//extension MuscleGroupView.Detail {
//    struct Glutes: View {
//        var body: some View {
//            List {
//                Group {
////                    Section {
////                        Bubble {
////                            Text("The glutes, or gluteal muscles, are a group of muscles in the buttocks region. They play a central role in hip extension, abduction, external rotation, and pelvic stability.")
////                        }
////                    }
////                    .listRowSeparator(.hidden, edges: .top)
//                    
//                    Section("Primary muscles in group") {
//                        ForEach(Array([
//                            (name: "Gluteus Maximus", description: "The largest of the three, primarily responsible for hip extension and outward rotation of the hip."),
//                            (name: "Gluteus Medius", description: "Located on the outer surface of the pelvis, it's involved in hip abduction and internal/external rotation. It also plays a significant role in pelvic stabilization, especially during single-leg movements."),
//                            (name: "Gluteus Minimus", description: "Situated beneath the gluteus medius, it assists in hip abduction and medial rotation."),
//                        ].enumerated()), id: \.offset) { index, muscle in
//                            HStack(alignment: .top) {
//                                Image(systemName: "\(index + 1).circle")
//                                    .foregroundColor(.secondary)
//                                Text(muscle.name).bold()
//                                + Text(": \(muscle.description)")
//                            }
//                        }
//                    }
//                    
//                    Section("Antagonist muscle group") {
//                        Text("The primary antagonists to the glutes, especially the gluteus maximus, are the hip flexors. The primary hip flexors include the ")
//                        + Text("Iliopsoas").bold()
//                        + Text(" group (psoas major and iliacus) and the Rectus Femoris (a part of the quadriceps).")
//                    }
//                    
//                    Section("Common exercises that target the glutes") {
//                        ForEach(Array([
//                            (name: "Squats", description: "Whether it's bodyweight, barbell, or goblet squats, the glutes are heavily engaged during the upward phase."),
//                            (name: "Deadlifts", description: "A compound movement that requires significant hip extension, which engages the glutes."),
//                            (name: "Lunges", description: "Forward, reverse, or lateral lunges all activate the glutes to various degrees."),
//                            (name: "Hip Thrusts", description: "Performed with a barbell or bodyweight, it specifically targets the gluteus maximus."),
//                            (name: "Glute Bridges", description: "A floor-based exercise where the hips are lifted off the ground to engage the glutes."),
//                            (name: "Step-Ups", description: "Stepping onto a platform or bench, especially with added weight, targets the glutes."),
//                            (name: "Clamshells", description: "A side-lying exercise where the knees are bent and the top leg is lifted, targeting the gluteus medius."),
//                            (name: "Fire Hydrants", description: "On hands and knees, lifting one leg out to the side."),
//                            (name: "Donkey Kicks", description: "On hands and knees, kicking one leg backward."),
//                            (name: "Cable Kickbacks", description: "Using a cable machine to kick one leg backward, engaging the glutes."),
//                        ].enumerated()), id: \.offset) { index, muscle in
//                            HStack(alignment: .top) {
//                                Image(systemName: "\(index + 1).circle")
//                                    .foregroundColor(.secondary)
//                                Text(muscle.name).bold()
//                                + Text(": \(muscle.description)")
//                            }
//                        }
//                    }
//                    
////                    Section {
////                        Bubble {
////                            Text("Training the glutes is essential not just for aesthetic reasons, but also for functional strength, athletic performance, and prevention of lower back and hip injuries. Proper engagement and activation of the glutes during exercises can significantly improve results and reduce the risk of injury.")
////                        }
////                    }
////                    .listRowSeparator(.hidden, edges: .top)
//                    
//                    Section("Looking for different muscle?") {
//                        MuscleGroupView.Navigator()
//                    }
//                }
//                .listRowSeparator(.hidden, edges: .bottom)
//            }
//            .listStyle(.plain)
//            .navigationTitle("Gluteal Muscles")
//            .navigationBarTitleDisplayMode(.inline)
//        }
//    }
//}
//
//extension MuscleGroupView.Detail {
//    struct Hamstrings: View {
//        var body: some View {
//            List {
//                Group {
////                    Section {
////                        Bubble {
////                            Text("The hamstrings are a group of muscles located at the back of the thigh. They play an essential role in knee flexion (bending) and hip extension (straightening).")
////                        }
////                    }
////                    .listRowSeparator(.hidden, edges: .top)
//                    
//                    Section("Primary muscles in group") {
//                        ForEach(Array([
//                            (name: "Biceps Femoris (both long and short heads)", description: "Located on the outer part of the back thigh."),
//                            (name: "Semitendinosus", description: "Situated medially in the back of the thigh, it's more superficial than the following muscle."),
//                            (name: "Semimembranosus", description: "Positioned deeper and medially to the semitendinosus."),
//                        ].enumerated()), id: \.offset) { index, muscle in
//                            HStack(alignment: .top) {
//                                Image(systemName: "\(index + 1).circle")
//                                    .foregroundColor(.secondary)
//                                Text(muscle.name).bold()
//                                + Text(": \(muscle.description)")
//                            }
//                        }
//                    }
//                    
//                    Section("Antagonist muscle group") {
//                        Text("The primary antagonists to the hamstrings are the ")
//                        + Text("Quadriceps").bold()
//                        + Text(". Located at the front of the thigh, the quadriceps are responsible for extending the knee and flexing the hip, making them opposite in action to the hamstrings.")
//                    }
//                    
//                    Section("Common exercises that target the hamstrings") {
//                        ForEach(Array([
//                            (name: "Deadlifts", description: "Whether conventional, Romanian, or stiff-legged, all versions target the hamstrings, especially during the lifting phase."),
//                            (name: "Leg Curls", description: "Using a leg curl machine, either lying or seated, to curl the weight by bending the knees."),
//                            (name: "Glute-Ham Raise", description: "A bodyweight exercise where the user begins in a horizontal position with their feet anchored and then lifts their torso by flexing the knees and extending the hips."),
//                            (name: "Swiss Ball Hamstring Curls", description: "Lying on the back with heels on a Swiss ball, curl the ball toward you by bending the knees and lifting the hips."),
//                            (name: "Single-Leg Deadlift", description: "Holding a dumbbell or kettlebell in one hand, hinge at the hip and lift the opposite leg backward."),
//                            (name: "Box Jumps", description: "Jumping onto a platform or box requires explosive power from the hamstrings."),
//                            (name: "Nordic Curls", description: "Kneeling on the floor with feet anchored, lower the torso forward while trying to control the descent using the hamstrings."),
//                            (name: "Reverse Lunges", description: "Stepping backward into a lunge position engages the hamstrings."),
//                            (name: "Good Mornings", description: "Holding a barbell on the back, hinge at the hips with a slight bend in the knees."),
//                            (name: "Cable Pull Throughs", description: "Using a cable machine with a rope attachment, stand facing away from the machine, grab the rope between the legs, and pull forward by extending the hips."),
//                        ].enumerated()), id: \.offset) { index, muscle in
//                            HStack(alignment: .top) {
//                                Image(systemName: "\(index + 1).circle")
//                                    .foregroundColor(.secondary)
//                                Text(muscle.name).bold()
//                                + Text(": \(muscle.description)")
//                            }
//                        }
//                    }
//                    
////                    Section {
////                        Bubble {
////                            Text("Training the hamstrings is crucial for balanced leg development, injury prevention (especially in sports that involve sprinting), and overall posterior chain strength. Proper flexibility and strength in the hamstrings also protect the lower back during many movements.")
////                        }
////                    }
////                    .listRowSeparator(.hidden, edges: .top)
//                    
//                    Section("Looking for different muscle?") {
//                        MuscleGroupView.Navigator()
//                    }
//                }
//                .listRowSeparator(.hidden, edges: .bottom)
//            }
//            .listStyle(.plain)
//            .navigationTitle("Hamstrings")
//            .navigationBarTitleDisplayMode(.inline)
//        }
//    }
//}
//
//extension MuscleGroupView.Detail {
//    struct Laterals: View {
//        var body: some View {
//            List {
//                Group {
////                    Section {
////                        Bubble {
////                            Text("The latissimus dorsi, commonly referred to as the \"lats\", are large, flat muscles located on the back that stretch to the sides, behind the arm. They are primarily responsible for actions such as shoulder adduction (bringing the arm down from a raised position), shoulder extension (moving the arm backward), and medial rotation of the upper arm.")
////                        }
////                    }
////                    .listRowSeparator(.hidden, edges: .top)
//                                        
//                    Section("Antagonist muscle group") {
//                        Text("The primary antagonists to the latissimus dorsi are the muscles of the ")
//                        + Text("Deltoid").bold()
//                        + Text(" group, especially the anterior (front) deltoids, due to their role in shoulder flexion (raising the arm). The pectoralis major also acts in opposition for certain movements, particularly shoulder horizontal adduction.")
//                    }
//                    
//                    Section("Common exercises that target the latissimus dorsi") {
//                        ForEach(Array([
//                            (name: "Pull-Ups/Chin-Ups", description: "Using a bar, pull yourself up by driving the elbows down and back. The grip variation (overhand for pull-ups, underhand for chin-ups) can change the emphasis slightly but both target the lats effectively."),
//                            (name: "Lat Pull-Down", description: "Using a cable machine with a bar attachment, pull the bar down to chest level."),
//                            (name: "Bent Over Rows", description: "Holding a barbell or dumbbells, hinge at the hips and pull the weight towards the lower rib cage."),
//                            (name: "Single-Arm Dumbbell Rows", description: "Supported on a bench with one knee and hand, pull a dumbbell with the opposite hand in a rowing motion."),
//                            (name: "T-Bar Rows", description: "Using a T-Bar or a landmine attachment, perform a rowing movement."),
//                            (name: "Seated Cable Rows", description: "Using a cable machine with a V-bar or wide grip handle, pull the handle towards you, squeezing the shoulder blades together."),
//                            (name: "Straight-Arm Lat Pull-Down", description: "Using a cable machine with a bar attachment, pull the bar down with straight arms, emphasizing the lats."),
//                            (name: "Dumbbell Pull-Over", description: "Lying perpendicular on a bench with a dumbbell held with both hands, lower the weight backwards and then use the lats to bring it back up."),
//                            (name: "Machine Rows", description: "Many gyms have various rowing machines that target the lats."),
//                            (name: "Face Pulls", description: "While primarily targeting the rear deltoids and upper traps, when executed with a focus on pulling the elbows wide, they can also engage the lats."),
//                        ].enumerated()), id: \.offset) { index, muscle in
//                            HStack(alignment: .top) {
//                                Image(systemName: "\(index + 1).circle")
//                                    .foregroundColor(.secondary)
//                                Text(muscle.name).bold()
//                                + Text(": \(muscle.description)")
//                            }
//                        }
//                    }
//                    
////                    Section {
////                        Bubble {
////                            Text("The latissimus dorsi contributes significantly to the V-taper appearance of the back, giving the illusion of a smaller waist. Beyond aesthetics, strong lats are crucial for many athletic movements, pull motions, and maintaining a healthy posture. Proper training of this muscle group can also aid in preventing back injuries.")
////                        }
////                    }
////                    .listRowSeparator(.hidden, edges: .top)
//                    
//                    Section("Looking for different muscle?") {
//                        MuscleGroupView.Navigator()
//                    }
//                }
//                .listRowSeparator(.hidden, edges: .bottom)
//            }
//            .listStyle(.plain)
//            .navigationTitle("Latissimus Dorsi")
//            .navigationBarTitleDisplayMode(.inline)
//        }
//    }
//}
//
//extension MuscleGroupView.Detail {
//    struct Lumbars: View {
//        var body: some View {
//            List {
//                Group {
////                    Section {
////                        Bubble {
////                            Text("The muscles associated with the lumbar region play an essential role in movements and stabilization of the spine. They support spinal flexion, extension, and lateral bending.")
////                        }
////                    }
////                    .listRowSeparator(.hidden, edges: .top)
//                    
//                    Section("Primary muscles in group") {
//                        ForEach(Array([
//                            (name: "Erector Spinae", description: "This is a group of muscles and tendons running vertically along the spine. It consists of three major muscles: the iliocostalis, longissimus, and spinalis. These muscles are responsible for extending and laterally bending the spine."),
//                            (name: "Quadratus Lumborum", description: "This deep muscle starts at the iliac crest (top of the pelvis) and attaches to the lumbar vertebrae and 12th rib. It plays a role in lateral bending of the spine and can also assist in extension."),
//                        ].enumerated()), id: \.offset) { index, muscle in
//                            HStack(alignment: .top) {
//                                Image(systemName: "\(index + 1).circle")
//                                    .foregroundColor(.secondary)
//                                Text(muscle.name).bold()
//                                + Text(": \(muscle.description)")
//                            }
//                        }
//                    }
//                    
//                    Section("Antagonist muscle group") {
//                        Text("The primary antagonists to the lumbar extensors are the ")
//                        + Text("Quadriceps").bold()
//                        + Text(" and ")
//                        + Text("Obliques").bold()
//                        + Text(". These abdominal muscles are responsible for spinal flexion (bending forward) and rotation, opposing the actions of the lumbar muscles.")
//                    }
//                    
//                    Section("Common exercises that target the lumbars") {
//                        ForEach(Array([
//                            (name: "Deadlifts", description: "A compound movement that heavily engages the erector spinae as you lift the weight and maintain a neutral spine."),
//                            (name: "Back Extensions/Hyperextensions", description: "Typically done on a hyperextension bench, where the individual lifts their upper body against gravity, targeting the erector spinae."),
//                            (name: "Good Mornings", description: "Holding a barbell on the upper back, hinge at the hips while keeping the back straight."),
//                            (name: "Supermans", description: "Lying face-down, lift both arms and legs off the ground, engaging the lower back muscles."),
//                            (name: "Bird-Dog", description: "Starting on hands and knees, extend one arm forward and the opposite leg back."),
//                            (name: "Bridges", description: "Lying on the back with feet flat on the ground, lift the hips by engaging the glutes and lower back."),
//                            (name: "Plank Variations", description: "While primarily targeting the core, maintaining a neutral spine engages the lumbar region."),
//                        ].enumerated()), id: \.offset) { index, muscle in
//                            HStack(alignment: .top) {
//                                Image(systemName: "\(index + 1).circle")
//                                    .foregroundColor(.secondary)
//                                Text(muscle.name).bold()
//                                + Text(": \(muscle.description)")
//                            }
//                        }
//                    }
//                    
////                    Section {
////                        Bubble {
////                            Text("Training the lumbar region is crucial for overall back health and preventing lower back pain, a common issue for many individuals. Ensuring proper technique and not overloading the spine is vital when engaging in exercises targeting this area.")
////                        }
////                    }
////                    .listRowSeparator(.hidden, edges: .top)
//                    
//                    Section("Looking for different muscle?") {
//                        MuscleGroupView.Navigator()
//                    }
//                }
//                .listRowSeparator(.hidden, edges: .bottom)
//            }
//            .listStyle(.plain)
//            .navigationTitle("Lumbars")
//            .navigationBarTitleDisplayMode(.inline)
//        }
//    }
//}
//
//extension MuscleGroupView.Detail {
//    struct Neck: View {
//        var body: some View {
//            List {
//                Group {
////                    Section {
////                        Bubble {
////                            Text("The neck contains several muscles that assist in the movement and stabilization of the head and cervical spine. The neck muscles also play a role in activities such as swallowing and speech.")
////                        }
////                    }
////                    .listRowSeparator(.hidden, edges: .top)
//                    
//                    Section("Primary muscles in group") {
//                        ForEach(Array([
//                            (name: "Sternocleidomastoid", description: "This muscle runs from the sternum and clavicle up to the mastoid process of the temporal bone. It's involved in flexion, rotation, and lateral flexion of the head."),
//                            (name: "Trapezius (Upper portion)", description: "While most of this muscle is located in the upper back, its upper fibers elevate the scapula and extend the neck."),
//                            (name: "Scalenes", description: "These are a group of muscles (anterior, middle, and posterior scalene) located on the sides of the neck, playing a role in neck flexion and lateral flexion."),
//                            (name: "Levator Scapulae", description: "Running from the upper scapula to the cervical vertebrae, this muscle elevates the scapula and assists in neck extension and lateral flexion."),
//                        ].enumerated()), id: \.offset) { index, muscle in
//                            HStack(alignment: .top) {
//                                Image(systemName: "\(index + 1).circle")
//                                    .foregroundColor(.secondary)
//                                Text(muscle.name).bold()
//                                + Text(": \(muscle.description)")
//                            }
//                        }
//                    }
//                    
//                    Section("Antagonist muscle group") {
//                        Text("The antagonists for the neck muscles are often other neck muscles, depending on the movement. For example:")
//                        
//                        Section {
//                            HStack(alignment: .top) {
//                                Image(systemName: "s.square")
//                                    .foregroundColor(.secondary)
//                                Text("For the ")
//                                + Text("Sternocleidomastoid").bold()
//                                + Text(", which aids in head flexion, the extensor muscles at the back of the neck (like the upper trapezius and splenius capitis) act as antagonists when they perform neck extension.")
//                            }
//                        }
//                    }
//                    
//                    Section("Common exercises that target the neck") {
//                        ForEach(Array([
//                            (name: "Neck Flexion", description: "Sitting or lying down, resist against a weight or hand while trying to touch the chin to the chest."),
//                            (name: "Neck Extension", description: "Lying face down, resist against a weight or hand while lifting the head."),
//                            (name: "Neck Lateral Flexion", description: "Sitting or standing, resist against a weight or hand while trying to touch the ear to the shoulder."),
//                            (name: "Neck Rotation", description: "Sitting or standing, resist against a weight or hand while trying to turn the head to the side."),
//                            (name: "Isometric Holds", description: "Pushing the head against a resistance (like your hand) without actual movement."),
//                            (name: "Shrugs", description: "While primarily targeting the upper trapezius, this exercise involves elevating the shoulders and can engage other neck muscles."),
//                        ].enumerated()), id: \.offset) { index, muscle in
//                            HStack(alignment: .top) {
//                                Image(systemName: "\(index + 1).circle")
//                                    .foregroundColor(.secondary)
//                                Text(muscle.name).bold()
//                                + Text(": \(muscle.description)")
//                            }
//                        }
//                    }
//                    
////                    Section {
////                        Bubble {
////                            Text("Training the neck is crucial, especially for individuals involved in contact sports, to prevent neck injuries. It's also essential for postural balance and health. Always use caution and appropriate weights when training the neck to avoid injury, and consider seeking guidance from a trained professional.")
////                        }
////                    }
////                    .listRowSeparator(.hidden, edges: .top)
//                    
//                    Section("Looking for different muscle?") {
//                        MuscleGroupView.Navigator()
//                    }
//                }
//                .listRowSeparator(.hidden, edges: .bottom)
//            }
//            .listStyle(.plain)
//            .navigationTitle("Neck")
//            .navigationBarTitleDisplayMode(.inline)
//        }
//    }
//}
//
//extension MuscleGroupView.Detail {
//    struct Obliques: View {
//        var body: some View {
//            List {
//                Group {
////                    Section {
////                        Bubble {
////                            Text("The obliques are abdominal muscles located on the sides of the torso. They are involved in flexing, rotating, and laterally flexing the torso.")
////                        }
////                    }
////                    .listRowSeparator(.hidden, edges: .top)
//                    
//                    Section("Primary muscles in group") {
//                        ForEach(Array([
//                            (name: "External Obliques", description: "These are situated on the outermost layer, running diagonally downward from the ribs to the pelvis."),
//                            (name: "Internal Obliques", description: "These are located just beneath the external obliques and run roughly perpendicular to them."),
//                        ].enumerated()), id: \.offset) { index, muscle in
//                            HStack(alignment: .top) {
//                                Image(systemName: "\(index + 1).circle")
//                                    .foregroundColor(.secondary)
//                                Text(muscle.name).bold()
//                                + Text(": \(muscle.description)")
//                            }
//                        }
//                    }
//                    
//                    Section("Antagonist muscle group") {
//                        Text("For the obliques, antagonistic actions can be a bit complex due to their role in multiple planes of movement. However, in terms of rotation, when the right obliques contract to rotate the torso to the left, the left obliques would act as the antagonist and vice versa.")
//                    }
//                    
//                    Section("Common exercises that target the obliques") {
//                        ForEach(Array([
//                            (name: "Russian Twists", description: "Sitting on the floor with knees bent and feet lifted slightly, rotate the torso and touch the ground beside the hip with a weight or hands."),
//                            (name: "Side Planks", description: "Holding the body in a plank position on one arm or elbow, which engages the underside oblique."),
//                            (name: "Bicycle Crunches", description: "Lying on the back, bring the opposite elbow to knee in a twisting motion."),
//                            (name: "Oblique V-Ups", description: "Lying on one side, simultaneously lift the legs and upper body towards each other."),
//                            (name: "Oblique Crunches", description: "Lying on the back with knees bent to one side, perform a crunching motion."),
//                            (name: "Windshield Wipers", description: "Lying on the back with legs raised, rotate the legs from side to side."),
//                            (name: "Standing Side Crunch", description: "Standing upright, lift one knee and lower the elbow on the same side to meet each other."),
//                            (name: "Woodchoppers", description: "Using a cable machine or resistance band, rotate the torso while pulling the weight diagonally from high to low or low to high."),
//                            (name: "Mason Twists", description: "Similar to Russian twists but performed with both feet on the ground."),
//                            (name: "Barbell or Dumbbell Side Bends", description: "Holding a weight in one hand, laterally flex the torso to one side and then return to the starting position."),
//                        ].enumerated()), id: \.offset) { index, muscle in
//                            HStack(alignment: .top) {
//                                Image(systemName: "\(index + 1).circle")
//                                    .foregroundColor(.secondary)
//                                Text(muscle.name).bold()
//                                + Text(": \(muscle.description)")
//                            }
//                        }
//                    }
//                    
////                    Section {
////                        Bubble {
////                            Text("Training the obliques is vital for core stability, functional movement, and producing a well-defined waistline. They also play a significant role in preventing back pain and enhancing athletic performance, especially in sports that involve twisting or turning.")
////                        }
////                    }
////                    .listRowSeparator(.hidden, edges: .top)
//                    
//                    Section("Looking for different muscle?") {
//                        MuscleGroupView.Navigator()
//                    }
//                }
//                .listRowSeparator(.hidden, edges: .bottom)
//            }
//            .listStyle(.plain)
//            .navigationTitle("Obliques")
//            .navigationBarTitleDisplayMode(.inline)
//        }
//    }
//}
//
//extension MuscleGroupView.Detail {
//    struct Pectorals: View {
//        var body: some View {
//            List {
//                Group {
////                    Section {
////                        Bubble {
////                            Text("The pectorals, commonly known as \"pecs\", are the major chest muscles located in the front of the rib cage. They are primarily involved in moving the shoulders and upper arms.")
////                        }
////                    }
////                    .listRowSeparator(.hidden, edges: .top)
//                    
//                    Section("Primary muscles in group") {
//                        ForEach(Array([
//                            (name: "Pectoralis Major", description: "This is the larger, more visible muscle that fans out across the chest. It has two heads: the clavicular head (upper chest) and the sternal head (lower chest)."),
//                            (name: "Pectoralis Minor", description: "Situated beneath the pectoralis major, it's a thin, triangular muscle that attaches the scapula to the ribs."),
//                        ].enumerated()), id: \.offset) { index, muscle in
//                            HStack(alignment: .top) {
//                                Image(systemName: "\(index + 1).circle")
//                                    .foregroundColor(.secondary)
//                                Text(muscle.name).bold()
//                                + Text(": \(muscle.description)")
//                            }
//                        }
//                    }
//                    
//                    Section("Antagonist muscle group") {
//                        Text("The primary antagonists to the pectorals are the muscles of the back, especially the ")
//                        + Text("rhomboids").bold()
//                        + Text(", ")
//                        + Text("trapezius").bold()
//                        + Text(" and ")
//                        + Text("latissimus dorsi").bold()
//                        + Text(". These muscles oppose the pectorals in movements such as retraction of the scapula and movement of the arm away from the front of the body.")
//                    }
//                    
//                    Section("Common exercises that target the pectorals") {
//                        ForEach(Array([
//                            (name: "Bench Press (Barbell or Dumbbell)", description: "Lying on a bench, press the weight vertically upwards. Variations include flat, incline (targets the upper pecs more), and decline (targets the lower pecs more)."),
//                            (name: "Push-Ups", description: "Using body weight, lower the body by bending the elbows and then push back up."),
//                            (name: "Chest Fly (Dumbbell or Cable)", description: "With arms slightly bent, open the arms wide and then squeeze the chest to bring the weights or cables together."),
//                            (name: "Pec Deck Machine", description: "Using a machine, squeeze the arms together from an outstretched position."),
//                            (name: "Cable Crossovers", description: "Using a cable machine with handles set to high, pull the handles down and across the body."),
//                            (name: "Dips (Chest Variation)", description: "Using parallel bars, lower the body with a slight forward lean to emphasize the chest."),
//                            (name: "Pullovers (Dumbbell or Barbell)", description: "Lying on a bench, hold the weight overhead with straight arms and then arc it backward and back over the chest."),
//                            (name: "Svend Press", description: "Holding a weight plate with both hands against the chest, press it outwards and then bring it back, maintaining tension on the chest."),
//                        ].enumerated()), id: \.offset) { index, muscle in
//                            HStack(alignment: .top) {
//                                Image(systemName: "\(index + 1).circle")
//                                    .foregroundColor(.secondary)
//                                Text(muscle.name).bold()
//                                + Text(": \(muscle.description)")
//                            }
//                        }
//                    }
//                    
////                    Section {
////                        Bubble {
////                            Text("Training the pectorals is crucial for overall upper body strength and aesthetics. A balanced approach to training, which also involves working the opposing back muscles, is essential for posture and shoulder health.")
////                        }
////                    }
////                    .listRowSeparator(.hidden, edges: .top)
//                    
//                    Section("Looking for different muscle?") {
//                        MuscleGroupView.Navigator()
//                    }
//                }
//                .listRowSeparator(.hidden, edges: .bottom)
//            }
//            .listStyle(.plain)
//            .navigationTitle("Pectorals")
//            .navigationBarTitleDisplayMode(.inline)
//        }
//    }
//}
//
//extension MuscleGroupView.Detail {
//    struct Quadriceps: View {
//        var body: some View {
//            List {
//                Group {
////                    Section {
////                        Bubble {
////                            Text("The quadriceps, often referred to as \"quads\", are a group of four powerful muscles located on the front of the thigh. Their primary function is knee extension and, to some extent, hip flexion.")
////                        }
////                    }
////                    .listRowSeparator(.hidden, edges: .top)
//                    
//                    Section("Primary muscles in group") {
//                        ForEach(Array([
//                            (name: "Rectus Femoris", description: "This muscle crosses both the hip and knee joints and is involved in hip flexion and knee extension."),
//                            (name: "Vastus Lateralis", description: "Located on the outer side of the thigh, it's involved in knee extension."),
//                            (name: "Vastus Medialis", description: "Situated on the inner part of the thigh, this muscle plays a role in knee extension. The teardrop-shaped portion of this muscle near the knee is called the \"Vastus Medialis Oblique\" and is particularly important for knee stability."),
//                            (name: "Vastus Intermedius", description: "This muscle lies beneath the rectus femoris and also contributes to knee extension."),
//                        ].enumerated()), id: \.offset) { index, muscle in
//                            HStack(alignment: .top) {
//                                Image(systemName: "\(index + 1).circle")
//                                    .foregroundColor(.secondary)
//                                Text(muscle.name).bold()
//                                + Text(": \(muscle.description)")
//                            }
//                        }
//                    }
//                    
//                    Section("Antagonist muscle group") {
//                        Text("The primary antagonists to the quadriceps are the ")
//                        + Text("hamstrings").bold()
//                        + Text(", located on the back of the thigh. They are responsible for knee flexion and hip extension, opposing the actions of the quads.")
//                    }
//                    
//                    Section("Common exercises that target the quadriceps") {
//                        ForEach(Array([
//                            (name: "Squats (Back, Front, Air, Goblet, etc.)", description: "A compound movement that involves bending at the hips and knees to lower the body and then standing back up."),
//                            (name: "Leg Press", description: "Using a leg press machine, push the weight upward by extending the knees."),
//                            (name: "Lunges", description: "Take a step forward, bending both knees to drop the hips, then push back to the starting position. Variations include walking lunges, reverse lunges, and side lunges."),
//                            (name: "Leg Extensions", description: "Using a leg extension machine, extend the knees to lift the weight."),
//                            (name: "Step-Ups", description: "Holding dumbbells or using bodyweight, step up onto a raised platform."),
//                            (name: "Bulgarian Split Squats", description: "With one foot elevated on a bench or platform behind you, perform a squatting motion with the front leg."),
//                            (name: "Hack Squats", description: "Using a hack squat machine, lower the body by bending the knees and then push back up."),
//                            (name: "Box Jumps", description: "Jump onto a raised platform from a squatting position."),
//                            (name: "Sissy Squats", description: "Bend the knees to lower the body while leaning backward, primarily targeting the quads."),
//                        ].enumerated()), id: \.offset) { index, muscle in
//                            HStack(alignment: .top) {
//                                Image(systemName: "\(index + 1).circle")
//                                    .foregroundColor(.secondary)
//                                Text(muscle.name).bold()
//                                + Text(": \(muscle.description)")
//                            }
//                        }
//                    }
//                    
////                    Section {
////                        Bubble {
////                            Text("Training the quadriceps is essential for leg strength, power, and overall function in daily activities and sports. As with all muscle groups, it's crucial to balance quad training with exercises that target their antagonists (in this case, the hamstrings) to ensure joint stability and reduce the risk of injuries.")
////                        }
////                    }
////                    .listRowSeparator(.hidden, edges: .top)
//                    
//                    Section("Looking for different muscle?") {
//                        MuscleGroupView.Navigator()
//                    }
//                }
//                .listRowSeparator(.hidden, edges: .bottom)
//            }
//            .listStyle(.plain)
//            .navigationTitle("Quadriceps")
//            .navigationBarTitleDisplayMode(.inline)
//        }
//    }
//}
//
//extension MuscleGroupView.Detail {
//    struct Trapezii: View {
//        var body: some View {
//            List {
//                Group {
////                    Section {
////                        Bubble {
////                            Text("The trapezius, often simply called \"traps\", is a large, kite-shaped muscle that extends from the base of the skull down to the middle of the back and laterally to the shoulder blade. It helps move and stabilize the scapula (shoulder blade) and supports the arm.")
////                        }
////                    }
////                    .listRowSeparator(.hidden, edges: .top)
//                    
//                    Section("Primary muscles in group") {
//                        ForEach(Array([
//                            (name: "Upper Trapezius", description: "Elevates the scapula and can aid in neck extension and lateral flexion."),
//                            (name: "Middle Trapezius", description: "Retracts (pulls together) the scapulae."),
//                            (name: "Lower Trapezius", description: "Depresses (lowers) the scapula."),
//                        ].enumerated()), id: \.offset) { index, muscle in
//                            HStack(alignment: .top) {
//                                Image(systemName: "\(index + 1).circle")
//                                    .foregroundColor(.secondary)
//                                Text(muscle.name).bold()
//                                + Text(": \(muscle.description)")
//                            }
//                        }
//                    }
//                    
//                    Section("Antagonist muscle group") {
//                        Text("The antagonists to the trapezius depend on the action:")
//                        
//                        Section {
//                            HStack(alignment: .top) {
//                                Image(systemName: "u.square")
//                                    .foregroundColor(.secondary)
//                                Text("For the upper traps, the antagonists are muscles like the ")
//                                + Text("pectoralis minor").bold()
//                                + Text(", which depress the scapula.")
//                            }
//                            HStack(alignment: .top) {
//                                Image(systemName: "m.square")
//                                    .foregroundColor(.secondary)
//                                Text("For the middle traps, the antagonists are the ")
//                                + Text("serratus anterior").bold()
//                                + Text(" and ")
//                                + Text("pectoralis major").bold()
//                                + Text(", which protract the scapula.")
//                            }
//                            HStack(alignment: .top) {
//                                Image(systemName: "l.square")
//                                    .foregroundColor(.secondary)
//                                Text("For the lower traps, the antagonists are muscles like the ")
//                                + Text("levator scapulae").bold()
//                                + Text(" and the upper fibers of the trapezius, which elevate the scapula.")
//                            }
//                        }
//                    }
//                    
//                    Section("Common exercises that target the trapezii") {
//                        ForEach(Array([
//                            (name: "Shrugs", description: "Holding weights in the hands, elevate the shoulders. This primarily targets the upper trapezius."),
//                            (name: "Upright Rows", description: "Holding a barbell or dumbbells, pull the weight vertically upwards, leading with the elbows. This targets the upper and middle traps."),
//                            (name: "Face Pulls", description: "Using a rope on a cable machine, pull the rope towards the face, aiming to separate the ends of the rope as it approaches you. This targets the middle and rear deltoids along with the traps."),
//                            (name: "Dumbbell or Barbell Rows", description: "Bend forward at the hips and pull the weight towards the torso. This targets the middle traps along with other back muscles."),
//                            (name: "Reverse Flyes", description: "Holding light weights, with a bent-over position, open the arms out to the sides. This targets the middle traps and rear deltoids."),
//                            (name: "T-Bar Rows", description: "Using a T-Bar or landmine attachment, pull the bar towards the torso. This involves the middle traps along with other back muscles."),
//                            (name: "Scapular Wall Slides", description: "This is more of a mobility and activation exercise. Standing with the back against a wall, slide the arms up and down, focusing on the movement of the scapula."),
//                            (name: "Y-Raises", description: "Lying prone on an incline bench, raise light weights diagonally upwards, forming a \"Y\" shape. This can target the lower traps."),
//                        ].enumerated()), id: \.offset) { index, muscle in
//                            HStack(alignment: .top) {
//                                Image(systemName: "\(index + 1).circle")
//                                    .foregroundColor(.secondary)
//                                Text(muscle.name).bold()
//                                + Text(": \(muscle.description)")
//                            }
//                        }
//                    }
//                    
////                    Section {
////                        Bubble {
////                            Text("The trapezius is vital for many daily activities and athletic movements. Training it can not only improve posture and shoulder health but can also enhance the overall appearance of the upper body. Properly stretching and activating the traps before heavy lifting can help prevent injuries and ensure balanced development.")
////                        }
////                    }
////                    .listRowSeparator(.hidden, edges: .top)
//                    
//                    Section("Looking for different muscle?") {
//                        MuscleGroupView.Navigator()
//                    }
//                }
//                .listRowSeparator(.hidden, edges: .bottom)
//            }
//            .listStyle(.plain)
//            .navigationTitle("Trapezii")
//            .navigationBarTitleDisplayMode(.inline)
//        }
//    }
//}
//
//extension MuscleGroupView.Detail {
//    struct Triceps: View {
//        var body: some View {
//            List {
//                Group {
////                    Section {
////                        Bubble {
////                            Text("The triceps brachii, commonly known as \"triceps\", is a three-headed muscle located on the back of the upper arm. Its primary function is to extend the elbow.")
////                        }
////                    }
////                    .listRowSeparator(.hidden, edges: .top)
//                    
//                    Section("Primary muscles in group") {
//                        ForEach(Array([
//                            (name: "Long Head", description: "Originates from the scapula (shoulder blade) and runs down the back of the arm."),
//                            (name: "Lateral Head", description: "Located on the outer side of the upper arm."),
//                            (name: "Medial Head", description: "Found beneath the long and lateral heads, closer to the body."),
//                        ].enumerated()), id: \.offset) { index, muscle in
//                            HStack(alignment: .top) {
//                                Image(systemName: "\(index + 1).circle")
//                                    .foregroundColor(.secondary)
//                                Text(muscle.name).bold()
//                                + Text(": \(muscle.description)")
//                            }
//                        }
//                    }
//                    
//                    Section("Antagonist muscle group") {
//                        Text("The primary antagonist to the triceps is the ")
//                        + Text("biceps brachii").bold()
//                        + Text(". While the triceps are responsible for elbow extension, the biceps control elbow flexion.")
//                    }
//                    
//                    Section("Common exercises that target the triceps") {
//                        ForEach(Array([
//                            (name: "Tricep Dips", description: "Using parallel bars or the edge of a bench or chair, lower the body by bending the elbows, then push back up."),
//                            (name: "Close-Grip Bench Press", description: "Similar to a regular bench press, but with hands placed closer together to emphasize triceps activation."),
//                            (name: "Skull Crushers (Lying Tricep Extensions)", description: "Lying on a bench, hold a barbell or dumbbells above the head, then bend the elbows to bring the weight towards the forehead before extending back up."),
//                            (name: "Tricep Pushdowns", description: "Using a cable machine with a bar or rope attachment, push the weight down by extending the elbows."),
//                            (name: "Overhead Tricep Extensions", description: "Holding a dumbbell or a cable attachment behind the head, extend the elbows to raise the weight."),
//                            (name: "Kickbacks", description: "Holding a dumbbell, with the elbow bent at a 90-degree angle, extend the arm straight back."),
//                            (name: "Triangle Push-Ups", description: "Similar to traditional push-ups, but with hands placed close together in a triangle formation."),
//                            (name: "Tricep Dumbbell Press", description: "Lying on a bench, hold a dumbbell in each hand above the chest, then lower the weights beside the head by bending the elbows, keeping them close to the body."),
//                            (name: "Diamond Push-Ups", description: "Like the triangle push-ups, place the hands close together, forming a diamond shape with the thumbs and index fingers."),
//                        ].enumerated()), id: \.offset) { index, muscle in
//                            HStack(alignment: .top) {
//                                Image(systemName: "\(index + 1).circle")
//                                    .foregroundColor(.secondary)
//                                Text(muscle.name).bold()
//                                + Text(": \(muscle.description)")
//                            }
//                        }
//                    }
//                    
////                    Section {
////                        Bubble {
////                            Text("Training the triceps is crucial for overall arm strength and aesthetics. Additionally, they play a significant role in pushing movements and exercises, making them essential for balanced upper body development. It's also important to ensure balanced training between the biceps and triceps to maintain joint health and stability.")
////                        }
////                    }
////                    .listRowSeparator(.hidden, edges: .top)
//                    
//                    Section("Looking for different muscle?") {
//                        MuscleGroupView.Navigator()
//                    }
//                }
//                .listRowSeparator(.hidden, edges: .bottom)
//            }
//            .listStyle(.plain)
//            .navigationTitle("Triceps Brachii")
//            .navigationBarTitleDisplayMode(.inline)
//        }
//    }
//}
//
//#if DEBUG
//#Preview("Abdominals") {
//    MuscleGroupView.Detail(muscleGroup: .abdominals)
//}
//#Preview("Abductors") {
//    MuscleGroupView.Detail(muscleGroup: .abductors)
//}
//#Preview("Adductors") {
//    MuscleGroupView.Detail(muscleGroup: .adductors)
//}
//#Preview("Biceps") {
//    MuscleGroupView.Detail(muscleGroup: .biceps)
//}
//#Preview("Calves") {
//    MuscleGroupView.Detail(muscleGroup: .calves)
//}
//#Preview("Deltoids") {
//    MuscleGroupView.Detail(muscleGroup: .deltoids)
//}
//#Preview("Forearms") {
//    MuscleGroupView.Detail(muscleGroup: .forearms)
//}
//#Preview("Glutes") {
//    MuscleGroupView.Detail(muscleGroup: .glutes)
//}
//#Preview("Hamstrings") {
//    MuscleGroupView.Detail(muscleGroup: .hamstrings)
//}
//#Preview("Laterals") {
//    MuscleGroupView.Detail(muscleGroup: .laterals)
//}
//#Preview("Lumbars") {
//    MuscleGroupView.Detail(muscleGroup: .lumbars)
//}
//#Preview("Neck") {
//    MuscleGroupView.Detail(muscleGroup: .neck)
//}
//#Preview("Obliques") {
//    MuscleGroupView.Detail(muscleGroup: .obliques)
//}
//#Preview("Pectorals") {
//    MuscleGroupView.Detail(muscleGroup: .pectorals)
//}
//#Preview("Quadriceps") {
//    MuscleGroupView.Detail(muscleGroup: .quadriceps)
//}
//#Preview("Trapezii") {
//    MuscleGroupView.Detail(muscleGroup: .trapezii)
//}
//#Preview("Triceps") {
//    MuscleGroupView.Detail(muscleGroup: .triceps)
//}
//#endif
