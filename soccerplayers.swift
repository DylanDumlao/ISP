import Foundation
import Scenes
import Igis

class soccerPlayer : RenderableEntity {
    let soccerPlayer1: Image
    let soccerPlayer2: Image

    var destrect1: Rect
    var destrect2: Rect
    init() {

        guard let soccerPlayer1URL = URL(string:"https://cdn.discordapp.com/attachments/971549552614199347/973045968893280297/unknown.png") else {
            fatalError("Failed to create URL for soccerPlayer1")
        }
        soccerPlayer1 = Image(sourceURL:soccerPlayer1URL)

        guard let soccerPlayer2URL = URL(string:"https://cdn.discordapp.com/attachments/971549552614199347/973046154621255771/unknown.png") else {
            fatalError("Failed to create URL for soccerPlayer2")
        }
        soccerPlayer2 = Image(sourceURL:soccerPlayer2URL)
    
        destrect1 = Rect(topLeft:Point(x:0, y:0), size:Size(width:100, height:100))
        destrect2 = Rect(topLeft:Point(x:0, y:0), size:Size(width:1, height:1))

    }


override func setup(canvasSize:Size, canvas:Canvas) {
    canvas.setup(soccerPlayer1)
    canvas.setup(soccerPlayer2)
}
override func render(canvas:Canvas) {

    if soccerPlayer1.isReady {
        soccerPlayer1.renderMode = .destinationRect(destrect1)
        canvas.render(soccerPlayer1)
    }
    if soccerPlayer2.isReady {
        soccerPlayer2.renderMode = .destinationRect(destrect2)
        canvas.render(soccerPlayer2)
    }
}
}
