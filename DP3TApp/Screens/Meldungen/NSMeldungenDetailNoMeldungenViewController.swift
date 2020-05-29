/*
 * Created by Ubique Innovation AG
 * https://www.ubique.ch
 * Copyright (c) 2020. All rights reserved.
 */

import UIKit

class NSMeldungenDetailNoMeldungenViewController: NSTitleViewScrollViewController {
    
    fileprivate var viewModel: MeldungenDetailNoMeldungenViewModel!
    
    // MARK: - Init

    override init() {
        super.init()
        viewModel = MeldungenDetailNoMeldungenViewModel()
        titleView = NSMeldungenDetailNoMeldungenTitleView()
    }

    // MARK: - View

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }

    // MARK: - Setup

    private func setupLayout() {
        let whiteBoxView = NSSimpleModuleBaseView(title: viewModel.simpleModuleTitleText, subtitle: viewModel.simpleModuleSubtitleText, text: viewModel.simpleModuleText, image: UIImage(named: "illu-no-message"), subtitleColor: .ns_green)

        let buttonView = UIView()

        let externalLinkButton = NSExternalLinkButton(color: .ns_green)
        externalLinkButton.title = viewModel.externalLinkButtonTitleText
        externalLinkButton.touchUpCallback = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.externalLinkPressed()
        }

        buttonView.addSubview(externalLinkButton)
        externalLinkButton.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
            make.right.lessThanOrEqualToSuperview()
        }

        whiteBoxView.contentView.addSpacerView(NSPadding.medium)
        whiteBoxView.contentView.addArrangedView(buttonView)

        stackScrollView.addArrangedView(whiteBoxView)

        stackScrollView.addSpacerView(3.0 * NSPadding.large)

        stackScrollView.addArrangedView(NSOnboardingInfoView(icon: UIImage(named: "ic-meldung")!, text: viewModel.firstOnboardingInfoText, title: viewModel.firstOnboardingInfoTitle, leftRightInset: 0))

        stackScrollView.addSpacerView(2.0 * NSPadding.medium)

        stackScrollView.addArrangedView(NSOnboardingInfoView(icon: UIImage(named: "ic-tracing")!, text: viewModel.secondOnboardingInfoText, title: viewModel.secondOnboardingInfoTitle, leftRightInset: 0))

        stackScrollView.addSpacerView(3 * NSPadding.large)

        stackScrollView.addArrangedView(NSButton.faqButton(color: .ns_blue))

        stackScrollView.addSpacerView(NSPadding.large)
    }

    override var titleHeight: CGFloat {
        return super.titleHeight * NSFontSize.fontSizeMultiplicator
    }

    override var startPositionScrollView: CGFloat {
        return titleHeight - 30
    }

    // MARK: - Logic

    private func externalLinkPressed() {
        if let url = viewModel.externalLinkURL {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
