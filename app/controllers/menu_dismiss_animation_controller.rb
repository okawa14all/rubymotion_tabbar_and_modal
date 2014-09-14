class MenuDismissAnimationController

  def transitionDuration(transitionContext)
    0.8
  end

  def animateTransition(transitionContext)
    fromVC =
      transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)

    duration = self.transitionDuration(transitionContext)

    tableView = rmq(fromVC.view).find(UITableView).get

    # baseDelay = 0.3
    baseDelay = fromVC.baseDelay
    dt = 0.1
    cell_count = tableView.visibleCells.count
    fade_duration = baseDelay + cell_count * dt

    tableView.visibleCells.each_with_index do |cell, i|
      # xAnim = POPBasicAnimation.animationWithPropertyNamed(KPOPLayerPositionX)
      # xAnim.timingFunction = CAMediaTimingFunction.functionWithName(KCAMediaTimingFunctionEaseInEaseOut)
      # xAnim.fromValue = 0
      # xAnim.toValue = 1600

      xAnim = POPDecayAnimation.animationWithPropertyNamed(KPOPLayerPositionX)
      xAnim.velocity = 1600
      xAnim.beginTime = CACurrentMediaTime() + baseDelay + dt * i
      xAnim.completionBlock = -> (anim, finished) {
        puts "anim complete #{i}"
      }
      cell.layer.pop_addAnimation(xAnim, forKey: 'dismiss_table')
    end

    rmq(tableView).animate(
      duration: fade_duration,
      animations: -> (cq) {
        cq.style do |st|
          st.opacity = 0
        end
      },
      completion: -> (did_finish, q) {
        fromVC.view.removeFromSuperview
        transitionContext.completeTransition(true)
      }
    )
  end
end
