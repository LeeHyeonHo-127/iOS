import Foundation

struct StoryBrain{
    var stories: [Story] = [
        Story(title: "안녕하세요", choice1: "응 안녕", choice1Destination: 1, choice2: "뭘 봐", choice2Destination: 2),
        Story(title: "당신은 사랑하는 사람이 있나요?", choice1: "응", choice1Destination: 2, choice2: "알아서 뭐하게", choice2Destination: 3),
        Story(title: "사랑이 뭔지 말 해줄수 있나요?", choice1: "응", choice1Destination: 4, choice2: "알아서 뭐하게", choice2Destination: 3),
        Story(title: "너무하네요.\n 여유로울때 다시 말 걸어주세요", choice1: "응", choice1Destination: 0, choice2: "뭔데 이래라 저래라야", choice2Destination: 0),
        Story(title: "사랑이 무엇인지 말 해주세요", choice1: "싫어", choice1Destination: 3, choice2: "싫어", choice2Destination: 3)
    ]
    
    var storyNumber = 0
    
    func getStoryLabelText()->String{
        return stories[storyNumber].title
    }
    func getChoice1ButtonText()->String{
        return stories[storyNumber].choice1
    }
    func getChoice1ButtonDestination()->Int{
        return stories[storyNumber].choice1Destination
    }
    func getChoice2ButtonText()->String{
        return stories[storyNumber].choice2
    }
    func getChoice2ButtonDestination()->Int{
        return stories[storyNumber].choice2Destination
    }
    mutating func changeStoryNumber(targetNumber: Int){
        self.storyNumber = targetNumber
    }
}
