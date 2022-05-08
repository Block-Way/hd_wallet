#!/usr/bin/env bash

echo "[Post-Build] Load env variables"

pwd

set -o allexport
source .env.appcenter
set +o allexport

echo "APP_NAME              => $APP_NAME"
echo "APPCENTER_BRANCH      => $APPCENTER_BRANCH"
echo "APPCENTER_BUILD_ID    => $APPCENTER_BUILD_ID"

send_notification() {
    local platform
    local "${@}"

    echo "[Post-Build] Sending notify email to => $BUILD_NOTIFY_EMAILS"

    RELEASE=$([ "$APPCENTER_BRANCH" == "master" ] && echo "Production" || echo "Beta")
    CHANNEL=$([ "$APPCENTER_BRANCH" == "master" ] && echo "prod" || echo "beta")
    VERSION_FROM_PUB=$(cat pubspec.yaml | grep 'version' -B 0)
    VERSION=${VERSION_FROM_PUB/version:/}
    SUBJECT="$APP_NAME $RELEASE v$VERSION Build n.$APPCENTER_BUILD_ID [$platform]"
    DOWNLOAD_URL="https://install.appcenter.ms/orgs/lomocointeam/apps/$APP_NAME-$platform/distribution_groups/release-$CHANNEL"
    DOWNLOAD_LINK="<a href=\"${DOWNLOAD_URL}\">Click here to download it</a>"

    TO_ADDRESS=$BUILD_NOTIFY_EMAILS
    TO_ADDRESS_FAILED=$BUILD_NOTIFY_EMAILS
    SUCCESS_BODY="We publish a new version: <b>$SUBJECT</b>!"
    FAILURE_BODY="Sorry! Your AppCenter Build failed. Please review the logs and try again."

    if [ "$AGENT_JOBSTATUS" == "Succeeded" ]; then
        (
            echo "From: frontend@dabank.io"
            echo "To: $TO_ADDRESS"
            echo "MIME-Version: 1.0"
            echo "Content-Type: multipart/alternative; "
            echo ' boundary="app_release"'
            echo "Subject: $SUBJECT"
            echo ""
            echo "This is a MIME-encapsulated message"
            echo ""
            echo "--app_release"
            echo "Content-Type: text/html"
            echo ""
            echo "<html>
                <head>
                    <title>$APP_NAME Release</title>
                </head>
                <body>
                    <p>$SUCCESS_BODY</p>
                    <p>$DOWNLOAD_LINK</p>
                    <p>If the link doesn't work, use this url:</p>
                    <p>$DOWNLOAD_URL</p>
                    <p>ChangeLog:</p>
                    <p></p>
                    <br>
                </body>
                </html>"
            echo "------app_release--"
        ) | sendmail -t
        # curl --request POST \
        #     --url https://api.sendgrid.com/v3/mail/send \
        #     --header "Authorization: Bearer $SENDGRID_API_KEY" \
        #     --header 'Content-Type: application/json' \
        #     --data '{
        #         "template_id": "d-51d30efab45f43309b55eb29a24c7119",
        #         "from": {"email": $BUILD_NOTIFY_EMAILS},
        #         "personalizations": [{
        #             "dynamic_template_data": {
        #                 "version": "'$VERSION'",
        #                 "build_id": "'$APPCENTER_BUILD_ID'"
        #                 "download_url": "'$DOWNLOAD_URL'",
        #                 "channel": "'$CHANNEL'",
        #                 "platform": "'$platform'",
        #             },
        #             "to": [{"email": $BUILD_NOTIFY_EMAILS}, {"email": "frontend@dabank.io"}]
        #         }],
        #     }'
        echo "[Post-Build] Build success: Email sent: download url: $DOWNLOAD_URL"
    else
        APPCENTER_URL=https://appcenter.ms/orgs/LoMoCoinTeam/apps/$APP_NAME-$platform/build/branches/$APPCENTER_BRANCH/builds/$APPCENTER_BUILD_ID
        echo -e ${FAILURE_BODY} ${APPCENTER_URL} | mail -s "${SUBJECT} - Failed!" ${TO_ADDRESS_FAILED}
        echo "[Post-Build] Build Failed: Email sent"
    fi
}

# Notify only for master and beta branch
if [ "$APPCENTER_BRANCH" == "master" ] || [ "$APPCENTER_BRANCH" == "beta" ]; then
    echo "[Post-Build] Notify build finish"
    if [ -z "$APPCENTER_XCODE_PROJECT" ]; then
        send_notification platform="Android"
    else
        send_notification platform="iOs"
    fi
fi
