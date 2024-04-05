//
//  main.swift
//  swift-starter-Round5
//
//  Created by 박채현 on 2024/04/02.
//

import Foundation

class Person {
    var name: String
    var height: Int
    
    init(name: String, height: Int) {
        self.name = name
        self.height = height
    }
}

enum Level {
    case A, B, C
}

protocol Talent {
    var singing: Level { get set }
    var dancing: Level { get set }
    var acting: Level { get set }
}

protocol BadPersonality {
    var frequencyOfCursing: Level { get set }
}

class TalentedPerson: Person, Talent {
    var singing: Level
    var dancing: Level
    var acting: Level
    
    init(name: String, height: Int, singing: Level, dancing: Level, acting: Level) {
        self.singing = singing
        self.dancing = dancing
        self.acting = acting
        super.init(name: name, height: height)
    }
}

class TalentedPersonWithBadPersonality: Person, Talent, BadPersonality {
    var singing: Level
    var dancing: Level
    var acting: Level
    var frequencyOfCursing: Level
    
    init(name: String, height: Int, singing: Level, dancing: Level, acting: Level, frequencyOfCursing: Level) {
        self.singing = singing
        self.dancing = dancing
        self.acting = acting
        self.frequencyOfCursing = frequencyOfCursing
        super.init(name: name, height: height)
    }
}

struct AuditionManager {
    public private(set) var totalApplicantsList = Array<Person>()
    private var passedApplicantsList = Array<Person>()
    
    mutating func cast(applicant: Person) {
        
        if let talent = applicant as? Talent {
            if (talent.singing == Level.A || talent.dancing == Level.A || talent.acting == Level.A) {
                passedApplicantsList.append(applicant)
            }
            totalApplicantsList = passedApplicantsList.filter{ applicant in
                !(applicant is BadPersonality)}
        }
    }
    
    func announcePassedApplicants() {
        let list = totalApplicantsList.map { $0.name }.joined(separator: "\n")
        print(
        "---합격자 명단---" + "\n" +
        list + "\n" +
        "--------------" + "\n" +
        "축하합니다!!"
        )
    }
}
    



let yagom = TalentedPerson(name: "yagom", height: 100, singing: .B, dancing: .A, acting: .C)
let noroo = Person(name: "noroo", height: 1000)
let summer = TalentedPerson(name: "summer", height: 900, singing: .B, dancing: .B, acting: .B)
let jamking = TalentedPerson(name: "jamking", height: 200, singing: .A, dancing: .C, acting: .C)
let finnn = TalentedPersonWithBadPersonality(name: "finnn", height: 400, singing: .A, dancing: .A, acting: .A, frequencyOfCursing: .A)

var auditionManager = AuditionManager()

auditionManager.cast(applicant: yagom)
auditionManager.cast(applicant: noroo)
auditionManager.cast(applicant: summer)
auditionManager.cast(applicant: jamking)
auditionManager.cast(applicant: finnn)

auditionManager.announcePassedApplicants()



