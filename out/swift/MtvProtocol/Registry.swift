/// Auto-generated payload registry (v2.0)
import Foundation

public enum PayloadRegistry {
    public static func decode(namespace: String, event: String, payload: [String: Any]) -> Any? {
        switch (namespace, event) {
        case ("edge", "edge_session_started"):
            return try? JSONDecoder().decode(
                edge_session_startedPayload.self,
                from: JSONSerialization.data(withJSONObject: payload)
            )
        case ("edge", "edge_ready"):
            return edge_readyPayload()
        case ("edge", "edge_mic_audio_chunk"):
            return try? JSONDecoder().decode(
                edge_mic_audio_chunkPayload.self,
                from: JSONSerialization.data(withJSONObject: payload)
            )
        case ("edge", "edge_qr_code"):
            return try? JSONDecoder().decode(
                edge_qr_codePayload.self,
                from: JSONSerialization.data(withJSONObject: payload)
            )
        case ("edge", "edge_session_ended"):
            return edge_session_endedPayload()
        case ("edge", "edge_pair_code"):
            return try? JSONDecoder().decode(
                edge_pair_codePayload.self,
                from: JSONSerialization.data(withJSONObject: payload)
            )
        case ("edge", "edge_render_update"):
            return try? JSONDecoder().decode(
                edge_render_updatePayload.self,
                from: JSONSerialization.data(withJSONObject: payload)
            )
        case ("karaoke", "karaoke_song_selected"):
            return try? JSONDecoder().decode(
                karaoke_song_selectedPayload.self,
                from: JSONSerialization.data(withJSONObject: payload)
            )
        case ("karaoke", "karaoke_lyric_timeline"):
            return try? JSONDecoder().decode(
                karaoke_lyric_timelinePayload.self,
                from: JSONSerialization.data(withJSONObject: payload)
            )
        case ("karaoke", "karaoke_performance_scored"):
            return try? JSONDecoder().decode(
                karaoke_performance_scoredPayload.self,
                from: JSONSerialization.data(withJSONObject: payload)
            )
        case ("karaoke", "karaoke_song_started"):
            return try? JSONDecoder().decode(
                karaoke_song_startedPayload.self,
                from: JSONSerialization.data(withJSONObject: payload)
            )
        case ("karaoke", "karaoke_song_paused"):
            return karaoke_song_pausedPayload()
        case ("karaoke", "karaoke_song_completed"):
            return try? JSONDecoder().decode(
                karaoke_song_completedPayload.self,
                from: JSONSerialization.data(withJSONObject: payload)
            )
        case ("karaoke", "karaoke_song_registration_accepted"):
            return try? JSONDecoder().decode(
                karaoke_song_registration_acceptedPayload.self,
                from: JSONSerialization.data(withJSONObject: payload)
            )
        case ("karaoke", "karaoke_song_registered"):
            return try? JSONDecoder().decode(
                karaoke_song_registeredPayload.self,
                from: JSONSerialization.data(withJSONObject: payload)
            )
        case ("karaoke", "karaoke_queue_updated"):
            return try? JSONDecoder().decode(
                karaoke_queue_updatedPayload.self,
                from: JSONSerialization.data(withJSONObject: payload)
            )
        case ("karaoke", "karaoke_scoring_update"):
            return try? JSONDecoder().decode(
                karaoke_scoring_updatePayload.self,
                from: JSONSerialization.data(withJSONObject: payload)
            )
        case ("karaoke", "karaoke_song_resumed"):
            return karaoke_song_resumedPayload()
        case ("phone", "phone_leader_transferred"):
            return try? JSONDecoder().decode(
                phone_leader_transferredPayload.self,
                from: JSONSerialization.data(withJSONObject: payload)
            )
        case ("phone", "phone_request_leader"):
            return phone_request_leaderPayload()
        case ("phone", "phone_disconnect"):
            return phone_disconnectPayload()
        case ("phone", "phone_join_approved"):
            return try? JSONDecoder().decode(
                phone_join_approvedPayload.self,
                from: JSONSerialization.data(withJSONObject: payload)
            )
        case ("phone", "phone_join_rejected"):
            return try? JSONDecoder().decode(
                phone_join_rejectedPayload.self,
                from: JSONSerialization.data(withJSONObject: payload)
            )
        case ("phone", "phone_ping"):
            return phone_pingPayload()
        case ("phone", "phone_role_assigned"):
            return try? JSONDecoder().decode(
                phone_role_assignedPayload.self,
                from: JSONSerialization.data(withJSONObject: payload)
            )
        case ("phone", "phone_submit_vote"):
            return try? JSONDecoder().decode(
                phone_submit_votePayload.self,
                from: JSONSerialization.data(withJSONObject: payload)
            )
        case ("phone", "phone_submit_choice"):
            return try? JSONDecoder().decode(
                phone_submit_choicePayload.self,
                from: JSONSerialization.data(withJSONObject: payload)
            )
        case ("phone", "phone_singer_ready"):
            return try? JSONDecoder().decode(
                phone_singer_readyPayload.self,
                from: JSONSerialization.data(withJSONObject: payload)
            )
        case ("phone", "phone_user_registered"):
            return try? JSONDecoder().decode(
                phone_user_registeredPayload.self,
                from: JSONSerialization.data(withJSONObject: payload)
            )
        case ("phone", "phone_join_room"):
            return try? JSONDecoder().decode(
                phone_join_roomPayload.self,
                from: JSONSerialization.data(withJSONObject: payload)
            )
        case ("system", "system_group_registered"):
            return try? JSONDecoder().decode(
                system_group_registeredPayload.self,
                from: JSONSerialization.data(withJSONObject: payload)
            )
        case ("system", "system_response_status"):
            return try? JSONDecoder().decode(
                system_response_statusPayload.self,
                from: JSONSerialization.data(withJSONObject: payload)
            )
        case ("system", "system_state_update"):
            return try? JSONDecoder().decode(
                system_state_updatePayload.self,
                from: JSONSerialization.data(withJSONObject: payload)
            )
        case ("system", "system_request_status"):
            return system_request_statusPayload()
        case ("system", "system_session_closed"):
            return system_session_closedPayload()
        case ("system", "system_phase_changed"):
            return try? JSONDecoder().decode(
                system_phase_changedPayload.self,
                from: JSONSerialization.data(withJSONObject: payload)
            )
        case ("system", "system_outro_message"):
            return try? JSONDecoder().decode(
                system_outro_messagePayload.self,
                from: JSONSerialization.data(withJSONObject: payload)
            )
        case ("system", "system_error"):
            return try? JSONDecoder().decode(
                system_errorPayload.self,
                from: JSONSerialization.data(withJSONObject: payload)
            )
        case ("system", "system_heartbeat"):
            return system_heartbeatPayload()
        case ("bccc", "bccc_session_setup"):
            return try? JSONDecoder().decode(
                bccc_session_setupPayload.self,
                from: JSONSerialization.data(withJSONObject: payload)
            )
        case ("bccc", "bccc_vote_closed"):
            return try? JSONDecoder().decode(
                bccc_vote_closedPayload.self,
                from: JSONSerialization.data(withJSONObject: payload)
            )
        case ("bccc", "bccc_user_response"):
            return try? JSONDecoder().decode(
                bccc_user_responsePayload.self,
                from: JSONSerialization.data(withJSONObject: payload)
            )
        case ("bccc", "bccc_prompt_sent"):
            return try? JSONDecoder().decode(
                bccc_prompt_sentPayload.self,
                from: JSONSerialization.data(withJSONObject: payload)
            )
        case ("bccc", "bccc_challenge_ended"):
            return bccc_challenge_endedPayload()
        case ("bccc", "bccc_round_result"):
            return try? JSONDecoder().decode(
                bccc_round_resultPayload.self,
                from: JSONSerialization.data(withJSONObject: payload)
            )
        case ("bccc", "bccc_session_configured"):
            return try? JSONDecoder().decode(
                bccc_session_configuredPayload.self,
                from: JSONSerialization.data(withJSONObject: payload)
            )
        case ("bccc", "bccc_ai_judgement"):
            return try? JSONDecoder().decode(
                bccc_ai_judgementPayload.self,
                from: JSONSerialization.data(withJSONObject: payload)
            )
        case ("bccc", "bccc_vote_results"):
            return try? JSONDecoder().decode(
                bccc_vote_resultsPayload.self,
                from: JSONSerialization.data(withJSONObject: payload)
            )
        case ("bccc", "bccc_vote_opened"):
            return try? JSONDecoder().decode(
                bccc_vote_openedPayload.self,
                from: JSONSerialization.data(withJSONObject: payload)
            )
        case ("bccc", "bccc_challenge_started"):
            return try? JSONDecoder().decode(
                bccc_challenge_startedPayload.self,
                from: JSONSerialization.data(withJSONObject: payload)
            )
        default:
            return nil
        }
    }
}