require 'spec_helper'

module WhoToBlame
  describe Engine do
    describe ':append_migrations' do
      let(:append_migrations) do
        Rails.application.initializers.find do |initializer|
          initializer.name == :append_migrations
        end
      end
      let(:paths) { { 'db/migrate' => [] } }
      let(:config) { double(paths: paths) }
      let(:root) { Rails.application.root }
      let(:same_app) { double(root: root, config: config) }
      let(:different_app) { double(root: 'fake root', config: config) }

      it 'does not run if we are in the same app' do
        append_migrations.run(same_app)
        expect(paths['db/migrate']).to eq([])
      end

      it 'runs if we are in a different app' do
        append_migrations.run(different_app)
        expect(paths['db/migrate'].length).to eq(1)
        expect(paths['db/migrate'].first).to include('/who-to-blame/db/migrate')
      end
    end
  end
end
