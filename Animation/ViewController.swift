import UIKit

class ViewController: UIViewController {
    //현재 상태를 확인 할 변수 생성
    var flag: Int = 1
    
    //블록 애니메이션을 위한 변수
    var scale: CGFloat = 2
    var angle: Double = 180
    var boxView: UIView?
    
    @IBOutlet weak var imageView: UIImageView!
    
    //화면 터치 시작 메소드 재정의
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /*
        UIView.animate(withDuration: 3) {() -> Void in
            if self.flag == 1 {
                self.imageView.alpha = 0
            } else {
                self.imageView.alpha = 1
            }
            
            self.flag = -self.flag
        }
        */
        
        //스프링 효과
        /*
        UIView.animate(withDuration: 5.0, delay: 1.0, usingSpringWithDamping: 0.1, initialSpringVelocity: 3.0, options: [], animations: {() -> Void in
            
            self.imageView.center.y = 50.0
            self.imageView.alpha = 0.3
            
        }, completion: nil)
        */
        
        //블록 애니메이션 적용
        //터치 객체를 가져옴
        if let touch = touches.first {
            //터치가 발생한 좌표를 찾음
            let location = touch.location(in: self.view)
            //애니메이션 적용 방법을 생성
            let timing = UICubicTimingParameters(animationCurve: .easeInOut)
            //애니메이션 객체 생성
            let animator = UIViewPropertyAnimator(duration: 3.0, timingParameters: timing)
            //애니메이션 추가
            animator.addAnimations {
                //크기 변화
                let scaleTrans = CGAffineTransform(scaleX: self.scale, y: self.scale)
                //각도 변화 - 단위는 라디언
                let rotateTrans = CGAffineTransform(rotationAngle: CGFloat(self.angle * .pi / 180))
                //2개를 뷰에 적용
                self.boxView?.transform = scaleTrans.concatenating(rotateTrans)
                
                self.angle = (self.angle == 180 ? 360 : 180)
                self.scale = (self.scale == 2 ? 1 : 2)
                self.boxView?.backgroundColor = UIColor.purple
                self.boxView?.center = location
            }
            //애니메이션 종료 후 수행할 내용
            animator.addCompletion() {(_) -> Void in
                self.boxView?.backgroundColor = UIColor.yellow
            }
            
            //애니메이션 시작
            animator.startAnimation()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //블록 애니메이션을 위한 코드
        
        //기존 이미지 뷰 제거
        imageView.removeFromSuperview()
        
        //박스의 좌표와 크기를 생성해서 boxView를 만들고 색상을 적용한 후 화면에 출력
        let frame = CGRect(x: 20, y: 20, width: 50, height: 50)
        boxView = UIView(frame: frame)
        boxView?.backgroundColor = UIColor(displayP3Red: 0.5, green: 0.5, blue: 0.0, alpha: 1.0)
        self.view.addSubview(boxView!)
    }
}

