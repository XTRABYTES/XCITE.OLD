/********************************************************************************
** Form generated from reading UI file 'feedbackpage.ui'
**
** Created by: Qt User Interface Compiler version 5.11.1
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_FEEDBACKPAGE_H
#define UI_FEEDBACKPAGE_H

#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QLabel>
#include <QtWidgets/QRadioButton>
#include <QtWidgets/QVBoxLayout>
#include <QtWidgets/QWidget>

QT_BEGIN_NAMESPACE

class Ui_FeedbackPage
{
public:
    QVBoxLayout *verticalLayout;
    QLabel *label;
    QLabel *label_2;
    QRadioButton *acceptFeedback;
    QRadioButton *declineFeedback;

    void setupUi(QWidget *FeedbackPage)
    {
        if (FeedbackPage->objectName().isEmpty())
            FeedbackPage->setObjectName(QStringLiteral("FeedbackPage"));
        FeedbackPage->resize(491, 190);
        FeedbackPage->setMinimumSize(QSize(491, 190));
        verticalLayout = new QVBoxLayout(FeedbackPage);
        verticalLayout->setObjectName(QStringLiteral("verticalLayout"));
        label = new QLabel(FeedbackPage);
        label->setObjectName(QStringLiteral("label"));
        QSizePolicy sizePolicy(QSizePolicy::MinimumExpanding, QSizePolicy::Minimum);
        sizePolicy.setHorizontalStretch(0);
        sizePolicy.setVerticalStretch(0);
        sizePolicy.setHeightForWidth(label->sizePolicy().hasHeightForWidth());
        label->setSizePolicy(sizePolicy);
        label->setWordWrap(true);

        verticalLayout->addWidget(label);

        label_2 = new QLabel(FeedbackPage);
        label_2->setObjectName(QStringLiteral("label_2"));
        label_2->setOpenExternalLinks(true);

        verticalLayout->addWidget(label_2);

        acceptFeedback = new QRadioButton(FeedbackPage);
        acceptFeedback->setObjectName(QStringLiteral("acceptFeedback"));

        verticalLayout->addWidget(acceptFeedback);

        declineFeedback = new QRadioButton(FeedbackPage);
        declineFeedback->setObjectName(QStringLiteral("declineFeedback"));
        declineFeedback->setChecked(true);

        verticalLayout->addWidget(declineFeedback);


        retranslateUi(FeedbackPage);

        QMetaObject::connectSlotsByName(FeedbackPage);
    } // setupUi

    void retranslateUi(QWidget *FeedbackPage)
    {
        FeedbackPage->setWindowTitle(QApplication::translate("FeedbackPage", "Form", nullptr));
        label->setText(QApplication::translate("FeedbackPage", "Your feedback is very important to us. If you find a bug or want to suggest an improvement, we want to hear about it! By using this software you agree to provide us with bug reports if bugs are discovered.\n"
"\n"
"Please submit all feedback to our helpdesk at:", nullptr));
        label_2->setText(QApplication::translate("FeedbackPage", "<a href=\"https://support.xtrabytes.global\">https://support.xtrabytes.global</a>", nullptr));
        acceptFeedback->setText(QApplication::translate("FeedbackPage", "I agree to provide feedback if I encounter bugs.", nullptr));
        declineFeedback->setText(QApplication::translate("FeedbackPage", "I do not agree to provide feedback.", nullptr));
    } // retranslateUi

};

namespace Ui {
    class FeedbackPage: public Ui_FeedbackPage {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_FEEDBACKPAGE_H
