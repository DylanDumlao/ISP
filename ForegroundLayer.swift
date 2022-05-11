import Igis
import Scenes

  /*
     This class is responsible for the foreground Layer.
     Internally, it maintains the RenderableEntities for this layer.
   */


class ForegroundLayer : Layer {
    let leftScoreBoardRect = Rect(topLeft: Point(x: 100, y: 50), size: Size(width: 50, height: 100))
    let rightScoreBoardRect = Rect(topLeft: Point(x: 900, y:50), size: Size(width: 50, height: 100))


    var leftScore : Scoreboard
    var rightScore : Scoreboard
    



    init() {
        leftScore = Scoreboard(rect: leftScoreBoardRect)
        rightScore = Scoreboard(rect: rightScoreBoardRect)

        
    


          // Using a meaningful name can be helpful for debugging
          super.init(name:"Foreground")
          insert(entity:leftScore, at:.front)
          insert(entity:rightScore, at:.front)
    }
    func incrementLeftScore() {
        leftScore.incrementScore()
    }
    func incrementRightScore() {
        rightScore.incrementScore()
    }
    override func preSetup(canvasSize: Size, canvas: Canvas) {
        let paddleMargin = 120
        leftScore.move(to:Point(x: 100, y: canvasSize.center.y))
        rightScore.move(to:Point(x: 900, y: canvasSize.center.y))
        print("canvasSize.width: \(canvasSize.width)")
    }
}

      
