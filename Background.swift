import Scenes
import Igis
import Foundation
  /*
     This class is responsible for rendering the background.
   */


class Background : RenderableEntity {
    let soccer: Image
    var rect = Rect()
    
    
   
      init() {
          // Using a meaningful name can be helpful for debugging

          guard let soccerURL = URL(string:"https://www.hdwallpaperspulse.com/wp-content/uploads/2017/04/09/football-field-clipart-soccer.png") else {
              fatalError("Failed to create URL for soccer")
          }

          soccer = Image(sourceURL:soccerURL)

          super.init(name:"Background")

      }


      override func setup(canvasSize:Size, canvas:Canvas) {
          canvas.setup(soccer)
          rect = Rect(topLeft: Point.zero, size:canvasSize)
      }
      override func render(canvas: Canvas) {


          if soccer.isReady {
              soccer.renderMode = .destinationRect(rect)
              canvas.render(soccer)
          }

      }

}





