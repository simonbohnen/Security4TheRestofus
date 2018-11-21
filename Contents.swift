import PlaygroundSupport
import SpriteKit

public class Sun : SKSpriteNode {
    
    public init(view: SKView){
        
        let radius:CGFloat = 60
        
        //Initialize the outer circle
        let outerCircle = SKShapeNode(circleOfRadius: radius ) // Size of Circle
        outerCircle.fillColor = SKColor(red: 255/255.0, green: 255/255.0, blue: 204/255.0, alpha: 1)
        outerCircle.lineWidth = 0
        
        //Initialize the inner cirlce
        let innerCircle = SKShapeNode(circleOfRadius: radius - 10 ) // Size of Circle
        innerCircle.fillColor = SKColor(red: 255/255.0, green: 255/255.0, blue: 102/255.0, alpha: 1)
        innerCircle.lineWidth = 0
        
        //Make the inner circle a child of the outer circle
        outerCircle.addChild(innerCircle)
        
        //Create a texture out of the shapes
        let sunTexture = view.texture(from: outerCircle)
        
        super.init(texture: sunTexture, color: .black, size: CGSize(width: radius * 2, height: radius * 2))
        
        //Run the pulse animation
        let pulseUp = SKAction.scale(to: 1.1, duration: 1.0)
        let pulseDown = SKAction.scale(to: 1.0, duration: 1.0)
        let pulse = SKAction.sequence([pulseUp, pulseDown])
        let repeatPulse = SKAction.repeatForever(pulse)
        
        self.run(repeatPulse)
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


/*:
 
 # Security 4 the rest of us
 ## An interactive game made at HackaTUM 2018 to explain common IT Security threats easily.
 
 Nowadays it is more important than ever before to have a secure website because basically everything is working online today. This game uses a bank as an example to explain how common security issues can be found & fixed.
 
 */

/*:
 
 ## 1. Sensitive Data Exposure
 
 Data is often referred to as a new currency in today's world. Therefore it is also important to keep data secure as if it was money. Imagine your website is a bank and all your data is the bank's money.
 
 Add a vault to your money to keep your money/data safe of people who shouldn't access it!
 */
var hasVault:Bool = false
/*:
 
 ## 2. Using Components With Known Vulnerabilities
 
 Implementing components built by others can take a lot of work off your shoulders. Despite that, these components can bring problems with them that can cause a lot of trouble without you having any influence on that. So inform yourself about issues and keep your libraries up to date!
 
 Build stable code and stable buildings!
 */
var useStableColumn:Bool = false
/*:
 
 ## 3. Broken Authentication
 
 You probably want nobody to play around with your code so you should better check who wants to gain access to your codebase.
 
 Applied to the bank, you would not want everybody to be able to access the critical parts of the building.
 
 */
var accessRestricted:Bool = false




class GameScene: SKScene {
    var sceneWidth = 640
    var sceneHeight = 480
    
    override func didMove(to view: SKView) {
        let vault = childNode(withName: "vault")
        if !hasVault {
            vault?.removeFromParent()
        }
        let column_stable = childNode(withName: "column_stable")
        let column_instable = childNode(withName: "column_instable")
        if useStableColumn {
            column_instable?.removeFromParent()
        } else {
            column_stable?.removeFromParent()
        }
        let guy = childNode(withName: "guy")
        
        let sun = Sun(view: view)
        sun.position = CGPoint(x: -370, y: 200)
        addChild(sun)
        
        var distance : CGFloat
        if accessRestricted {
            distance = 300
        } else {
            distance = 500
        }
        
        let walk = SKAction.moveBy(x: distance, y: 0, duration: 5.0)
        
        var walkFrames : [SKTexture] = []
        walkFrames.append(SKTexture(imageNamed: "Felix 1.png"))
        walkFrames.append(SKTexture(imageNamed: "Felix 2.png"))
        walkFrames.append(SKTexture(imageNamed: "Felix 3.png"))
        
        let walkAnimation = SKAction.repeat(
            SKAction.animate(with: walkFrames,
                             timePerFrame: 0.15,
                             resize: false,
                             restore: false), count: 11)
        
        //Create an array with all actions that will be performed simultaneously
        var walkActions = Array<SKAction>()
        
        walkActions.append(walkAnimation)
        walkActions.append(walk)
        
        guy?.run(SKAction.group(walkActions))
    }
}

// Load the SKScene from 'GameScene.sks'
let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 640, height: 480))
if let scene = GameScene(fileNamed: "GameScene") {
    // Set the scale mode to scale to fit the window
    scene.scaleMode = .aspectFill
    // Present the scene
    sceneView.presentScene(scene)
}

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
