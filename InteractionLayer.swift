import Igis
import Scenes
import Foundation
  /*
     This class is responsible for the interaction Layer.
     Internally, it maintains the RenderableEntities for this layer.
   */

class InteractionLayer : Layer, KeyDownHandler {
    var canvasSize = Size(width: 0, height: 0)

    let ball = Ball()
   
    let paddleLeft = Paddle(rect:Rect(size:Size(width:10, height:100)))
    let paddleRight = Paddle(rect:Rect(size:Size(width:10, height:100)))
    let soccerPlayers = soccerPlayer()
    

    
      init() {

      
          


          // Using a meaningful name can be helpful for debugging
          super.init(name:"Interaction")
         
          // We insert our RenderableEntities in the constructor
          insert(entity: ball, at: .front)
          ball.changeVelocity(velocityX: 3, velocityY: 3)

          insert(entity: paddleLeft, at: .front)
          insert(entity: paddleRight, at: .front)
          insert(entity:soccerPlayers,at:.front)
      }      

     
      
      func onKeyDown(key:String, code:String, ctrlKey:Bool, shiftKey:Bool, altKey:Bool, metaKey:Bool) {

          let movement = 10
          switch(key) {
          case "w" :
              //left paddle up
              if paddleLeft.rectangle.rect.topLeft.y >= 50 {
                  paddleLeft.move(to:Point(x: paddleLeft.rectangle.rect.topLeft.x, y: paddleLeft.rectangle.rect.topLeft.y - movement))
              }
          case "s" :
              //left paddle down
              if paddleLeft.rectangle.rect.topLeft.y <= canvasSize.height - paddleRight.rectangle.rect.height - 50 {
                  paddleLeft.move(to:Point(x: paddleLeft.rectangle.rect.topLeft.x, y: paddleLeft.rectangle.rect.topLeft.y + movement))
              }
          case "i" :
              //right paddle up
              if paddleRight.rectangle.rect.topLeft.y >= 50 {
                  paddleRight.move(to:Point(x: paddleRight.rectangle.rect.topLeft.x, y: paddleRight.rectangle.rect.topLeft.y - movement))
              }
          case "k" :
              //right paddle down
              if paddleRight.rectangle.rect.topLeft.y <= canvasSize.height - paddleRight.rectangle.rect.height - 50 {
                  paddleRight.move(to:Point(x: paddleRight.rectangle.rect.topLeft.x, y: paddleRight.rectangle.rect.topLeft.y + movement))
              }
          default:
              ""
          }

          print("key: \(key), code: \(code), ctrlKey: \(ctrlKey), shiftKey: \(shiftKey), altKey: \(altKey), metaKey: \(metaKey)")

      }
    
   
                
      override func preSetup(canvasSize: Size, canvas: Canvas) {
          self.canvasSize = canvasSize

          paddleLeft.move(to:Point(x: 10, y: canvasSize.center.y))
          paddleRight.move(to:Point(x: canvasSize.width - 20, y: canvasSize.center.y))
          dispatcher.registerKeyDownHandler(handler: self)
          soccerPlayers.destrect1.topLeft = paddleLeft.rectangle.rect.topLeft
          soccerPlayers.destrect2.topRight = paddleRight.rectangle.rect.topRight
          soccerPlayers.destrect2.topLeft.x+=800
          print(soccerPlayers.destrect2.topLeft.x)
      }
      
      override func postTeardown() {
          dispatcher.unregisterKeyDownHandler(handler: self)
      }
      func mainScene() -> MainScene {
          guard let scene = scene as? MainScene else {
              fatalError("MainScene required")
          }
          return scene
      }
      func incrementLeftScore() {
          MainScene().incrementLeftScore()
      }
      func incrementRightScore() {
          MainScene().incrementRightScore()
      }
      override func preCalculate(canvas: Canvas) {

          soccerPlayers.destrect1.width = paddleLeft.rectangle.rect.width
          soccerPlayers.destrect1.height = paddleLeft.rectangle.rect.width
          soccerPlayers.destrect1.topLeft = paddleLeft.rectangle.rect.topLeft
          soccerPlayers.destrect2.topLeft = paddleRight.rectangle.rect.topLeft
          let ballCoundingRect = ball.boundingRect()
  
          let leftPaddleBoundingRect = paddleLeft.boundingRect()
          let leftPaddleContainment = leftPaddleBoundingRect.containment(target: ballCoundingRect)
          let leftPaddleTargetContainmentSet: ContainmentSet = [.overlapsRight, .contact]

          if leftPaddleTargetContainmentSet.isSubset(of: leftPaddleContainment){
              print("LEFT PADDLE IMPACTED")
              ball.velocityX = -ball.velocityX
              
          }

          let rightPaddleBoundingRect = paddleRight.boundingRect()
          let rightPaddleContainment = rightPaddleBoundingRect.containment(target: ballCoundingRect)
          let rightPaddleTargetContainmentSet: ContainmentSet = [.overlapsLeft, .contact]

          if rightPaddleTargetContainmentSet.isSubset(of: rightPaddleContainment){
              print("RIGHT PADDLE IMPACTED")
              ball.velocityX = -ball.velocityX
    
                  



          }
      }




}





      

